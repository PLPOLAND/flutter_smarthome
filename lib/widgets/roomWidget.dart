import 'package:flutter/material.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';
import 'package:provider/provider.dart';

import '../models/room.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Room room = Provider.of<Room>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          // transform: GradientRotation(1),
          colors: [
            Theme.of(context).colorScheme.primary,
            Color.alphaBlend(Colors.white.withAlpha(0x88),
                Theme.of(context).colorScheme.primary),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RoomDetailScreen.routeName, arguments: room);
        },
        child: Center(
          child: Text(
            room.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
