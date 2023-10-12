import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:provider/provider.dart';

class StatelessAutomationWidget extends StatelessWidget {
  final Automation automation;
  final double height = 100;
  final double iconSize = 35;
  const StatelessAutomationWidget({
    Key? key,
    required this.automation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (automation.icon != null)
                Icon(
                  automation.icon,
                  size: iconSize,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: automation.icon == null
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(automation.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              )),
                      if (automation.description != null)
                        Text(
                          automation.description!,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: automation.onClick,
                icon: const Icon(
                    Icons.play_arrow), //TODO: change icon to play_arrow/stop
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all<double>(iconSize),
                  alignment: Alignment.center,
                  iconColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color.alphaBlend(Colors.black.withAlpha(100),
                            Theme.of(context).colorScheme.onPrimaryContainer);
                      } else {
                        return Theme.of(context).colorScheme.onPrimaryContainer;
                      }
                    },
                  ),
                  shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
