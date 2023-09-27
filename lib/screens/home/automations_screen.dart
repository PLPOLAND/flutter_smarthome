import 'package:flutter/material.dart';
import 'package:flutter_smarthome/widgets/homeScreen/autmations/user_automation.dart';

class AutomationsScreen extends StatelessWidget {
  static const routeName = '/automations';

  const AutomationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        UserAutomation(),
      ],
    )));
  }
}
