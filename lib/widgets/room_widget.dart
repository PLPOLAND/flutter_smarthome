import 'package:flutter/material.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';

import '../models/room.dart';

class RoomWidget extends StatefulWidget {
  final Room room;
  const RoomWidget({required this.room, super.key});

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  bool _showOptions = false;

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          // transform: GradientRotation(1),
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Color.alphaBlend(Colors.black.withAlpha(0x55),
                Theme.of(context).colorScheme.primaryContainer),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RoomDetailScreen.routeName, arguments: room);
          },
          onLongPress: () {
            setState(() {
              _showOptions = !_showOptions;
            });
          },
          child: _showOptions
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      onPressed: () {
                        setState(() {
                          _showOptions = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/rooms/add-edit-room',
                            arguments: room.id);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      onPressed: () {},
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          room.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          room.toggleFavorite();
                        });
                      },
                      icon: Icon(
                          room.isFavorite
                              ? Icons.star
                              : Icons.star_border_outlined,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
