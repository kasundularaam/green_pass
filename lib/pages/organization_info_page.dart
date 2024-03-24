import 'package:green_pass/models/organization_model.dart';
import 'package:flutter/material.dart';

import 'package:green_pass/widgets/organization_data.dart';

class OrganizationInfoPage extends StatelessWidget {
  final Organization organization;
  OrganizationInfoPage({
    Key? key,
    required this.organization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Organization info",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
        child: Column(
          children: [
            OrganizationData(
              organization: organization,
            ),
          ],
        ),
      ),
    );
  }
}
