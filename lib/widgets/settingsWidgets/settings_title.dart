import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  final String text;

  const SettingsTitle(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
