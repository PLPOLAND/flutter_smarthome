import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAutomation extends StatelessWidget {
  final String name;
  final String? description;
  final IconData? icon;
  final Function() onClick;
  const UserAutomation({
    Key? key,
    required this.name,
    required this.onClick,
    this.description,
    this.icon,
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
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 40,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: icon == null
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              )),
                      if (description != null)
                        Text(
                          description!,
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
                onPressed: onClick,
                icon: const Icon(
                    Icons.play_arrow), //TODO: change icon to play_arrow/stop
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all<double>(40),
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
