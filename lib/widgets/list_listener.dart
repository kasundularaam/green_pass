// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:green_pass/models/failure.dart';
import 'package:green_pass/services/i_listener.dart';

class ListListener<T> extends StatefulWidget {
  final IListener<T> listener;
  final Widget Function(T item) itemBuilder;
  const ListListener({
    Key? key,
    required this.listener,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<ListListener<T>> createState() => _ListListenerState();
}

class _ListListenerState<T> extends State<ListListener<T>> {
  int _key = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: Key(_key.toString()),
      stream: widget.listener.listenToList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (error is Failure)
                  Text(
                    error.message,
                    textAlign: TextAlign.center,
                  ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _key++;
                      });
                    },
                    child: Text("Retry")),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          final dataList = snapshot.data;
          if (dataList == null) {
            return Center(
              child: Text(
                "Data not found",
                textAlign: TextAlign.center,
              ),
            );
          }
          if (dataList.isEmpty) {
            return Center(
              child: Text(
                "Empty",
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) =>
                  widget.itemBuilder(dataList[index]));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
