import 'package:flutter/material.dart';

class UserAutomation extends StatelessWidget {
  const UserAutomation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.person),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('User Automation'),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
          ],
        ),
      ),
    );
  }
}
