import 'package:flutter/material.dart';
import 'package:flutter_smarthome/widgets/homeScreen/autmations/user_automation.dart';

class AutomationsScreen extends StatelessWidget {
  static const routeName = '/automations';

  const AutomationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          UserAutomation(
            name: "testowy",
            description: "testowy opis",
            icon: Icons.ac_unit,
            onClick: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Funkcja Testowa"),
                ),
              );
            },
          ),
          UserAutomation(
            name: "testowy2",
            description: "testowy opis2",
            icon: Icons.access_alarm,
            onClick: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Funkcja Testowa2"),
                ),
              );
            },
          ),
        ],
      ),
    )));
  }
}
