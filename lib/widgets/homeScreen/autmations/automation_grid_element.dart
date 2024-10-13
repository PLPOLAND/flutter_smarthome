import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/automations/button_automation.dart';
import 'package:flutter_smarthome/models/automations/user_automation.dart';

class AutomationGridElement extends StatelessWidget {
  final Automation automation;
  final double iconSize;
  final bool active;

  const AutomationGridElement.stateless({
    super.key,
    required this.automation,
    double? iconSize,
  })  : iconSize = iconSize ?? 35,
        active = true;

  const AutomationGridElement.statefull({
    Key? key,
    required this.automation,
    double? iconSize,
    required this.active,
  })  : iconSize = iconSize ?? 35,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active
            ? Theme.of(context).colorScheme.primaryContainer
            : Color.alphaBlend(
                const Color.fromARGB(100, 0, 0, 0),
                Theme.of(context).colorScheme.primaryContainer,
              ),
        // color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Material(
        color: Colors.white.withOpacity(0),
        child: InkWell(
          onTap: automation is ButtonAutomation || automation is UserAutomation
              ? () => automation.onClick()
              : null,
          splashColor: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                        Text(
                          automation.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (automation.description != null)
                          Text(
                            automation.description!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
