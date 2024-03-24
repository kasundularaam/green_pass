import 'dart:async';
import 'dart:convert';

import 'package:green_pass/models/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart' as AppUser;
import '../sources/fake_users.dart';

class UserService {
  static bool get isSignedIn =>
      FirebaseAuth.instance.currentUser != null ? true : false;

  static String getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    throw Failure(message: "User not found");
  }

  static String getEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email!;
    }
    throw Failure(message: "User not found");
  }

  static Future<List<AppUser.User>> getAll() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<dynamic> res = json.decode(userRes);
      final List<AppUser.User> users = res
          .map((e) => AppUser.User.fromMap(e as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<AppUser.User> getCurrentUser() async {
    try {
      final id = getUserId();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = await firestore.collection('user').doc(id).get();
      return AppUser.User.fromMap(user.data() as Map<String, dynamic>);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<AppUser.User> getUserById(id) async {
    try {
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(id).get();

      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        final AppUser.User user = AppUser.User.fromMap(userData);

        return user;
      } else {
        throw Failure(message: 'User not found');
      }
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  static Future<void> userLogin(
      BuildContext context, userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw Failure(message: 'Invalid Login credentials');
      } else {
        throw Failure(message: "Unknown Error occurred");
      }
    } catch (e) {
      throw Failure(message: "message");
    }
  }

  static Future<void> userLogOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> userRegister(
    String userName,
    String userEmail,
    String userPhone,
    String userFaculty,
    String userPassword,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      user = userCredential.user;
      await user!.updateDisplayName(userName);
      await user.reload();
      user = auth.currentUser;

      FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
        "id": user.uid,
        'name': userName,
        'email': userEmail,
        'phone': userPhone,
        'faculty': userFaculty,
      });
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message ?? "Registration Failed!");
    } catch (e) {
      throw Failure(message: "message");
    }
  }

  static Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      throw Failure(message: "Failed to send email verification");
    }
  }

  static bool isVerified() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified;
    }
    return false;
  }

  // static Stream<bool> listenEmailVerification() async* {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     yield* Stream<bool>.periodic(const Duration(seconds: 1), (count) {});
  //   }
  //   throw AuthFailure(message: "Failed to listen email verification");
  // }

  static Future<void> checkEmailVerificationStatus(
      {required Function(int) onWaiting,
      required Function() onSucceed,
      required Function() onWaitingEnd,
      required Function(Failure) onFailed}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool isSucceed = false;
      for (var i = 0; i < 30; i++) {
        final User userForCheck = FirebaseAuth.instance.currentUser!;
        await Future.delayed(const Duration(seconds: 1));
        await userForCheck.reload();
        if (userForCheck.emailVerified) {
          isSucceed = true;
          break;
        }
        if (!userForCheck.emailVerified) {
          onWaiting(i);
        }
      }
      if (isSucceed) {
        onSucceed();
      } else {
        onWaitingEnd();
      }
    } else {
      onFailed(Failure(message: "User not found"));
    }
  }

  static Future<void> resetPassword(
      String userEmail, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: userEmail,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User not found"),
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
