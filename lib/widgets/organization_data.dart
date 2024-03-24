import 'package:green_pass/Services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:green_pass/models/organization_model.dart';

import '../models/user_model.dart';

class OrganizationData extends StatefulWidget {
  final Organization organization;
  OrganizationData({
    Key? key,
    required this.organization,
  }) : super(key: key);

  @override
  State<OrganizationData> createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.organization.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.organization.imageUrl,
                  width: 105,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.organization.orgName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.organization.orgEmail,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(
                "INFO",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.organization.orgDesc,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Admins",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: FutureBuilder<User>(
              future: UserService.getUserById(widget.organization.userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          "lib/assets/3d_avatar_18.png",
                          width: 44,
                          height: 44,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                snapshot.data!.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 38),
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<User>(
                future: UserService.getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        side: BorderSide(
                            width: 1,
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "New Event",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    );
                  }
                  return Text("Loading...");
                }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
