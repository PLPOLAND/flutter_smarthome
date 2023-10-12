import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/automations/user_automation.dart';
import 'package:flutter_smarthome/widgets/homeScreen/autmations/stateless_automation.dart';

class AutomationsScreen extends StatelessWidget {
  static const routeName = '/automations';

  const AutomationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StatelessAutomationWidget(
              automation: UserAutomation(
                id: 0,
                name: "testowy",
                description: "testowy opis testowej automatyzacji",
                onClick: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("test"),
                      showCloseIcon: true,
                    ),
                  );
                },
                userNickname: "testowy",
                icon: Icons.light,
              ),
            ),
            StatelessAutomationWidget(
              automation: UserAutomation(
                id: 1,
                name: "testowy2",
                onClick: () {},
                userNickname: "testowy2",
                icon: Icons.lightbulb,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
