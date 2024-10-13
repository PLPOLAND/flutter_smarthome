import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/bloc/automations/automations_bloc.dart';
import 'package:flutter_smarthome/widgets/homeScreen/autmations/automation_grid_element.dart';
import 'package:flutter_smarthome/widgets/group_widget.dart';

class AutomationsScreen extends StatelessWidget {
  static const routeName = '/automations';
  AutomationsScreen({Key? key}) : super(key: key);
  static int i = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutomationsBloc, AutomationsState>(
      builder: (context, state) {
        if (state.automation.isEmpty && i++ == 0) {
          context.read<AutomationsBloc>().add(LoadAutomations());
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GroupWidget(
                text: "Automations",
                expandable: true,
                children: [
                  ...state.automation.values
                      .map((e) => AutomationGridElement.statefull(
                            automation: e,
                            active: e.active,
                          ))
                      .toList(),
                  //   AutomationGridElement.stateless(
                  //     automation: Automation(
                  //       id: 0,
                  //       icon: Icons.ac_unit,
                  //       name:
                  //           "Bardzo długa nazwa testowa bardzo bardzo długa nazwa testowa",
                  //       // onClick: () {
                  //       //   ScaffoldMessenger.of(context).showSnackBar(
                  //       //     SnackBar(
                  //       //       content:
                  //       //           Text(MediaQuery.of(context).size.width.toString()),
                  //       //       showCloseIcon: true,
                  //       //       duration: const Duration(milliseconds: 500),
                  //       //     ),
                  //       //   );
                  //       // },
                  //       actions: [],
                  //     ),
                  //   ),
                  //   AutomationGridElement.stateless(
                  //     automation: Automation(
                  //       id: 1,
                  //       icon: Icons.lightbulb,
                  //       name: "test2",
                  //       // onClick: () {},
                  //       actions: List.empty(),
                  //     ),
                  //     // iconSize: 30,
                  //   ),
                ],
              ),
              // GroupWidget(text: "", children: [
              //   AutomationGridElement.statefull(
              //     automation: Automation(
              //       id: 2,
              //       icon: Icons.ac_unit,
              //       name: "test3",
              //       // onClick: () {},
              //       actions: List.empty(),
              //     ),
              //     active: false,
              //   ),
              // ])
            ],
          ),
        );
      },
    );
  }
}
