import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';
import 'package:flutter_smarthome/providers/sensors_provider.dart';
import 'package:provider/provider.dart';

class ButtonLocalClickFunctionsWidget extends StatelessWidget {
  final int? sensorID;
  const ButtonLocalClickFunctionsWidget({super.key, required this.sensorID});

  get buildButtonLocalClickFunctionWidget {
    return Container(
      child: Row(
        children: [
          Text("ButtonLocalClickFunctionWidget"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("ButtonLocalClickFunctionsWidget"),
          buildButtonLocalClickFunctionWidget,
        ],
      ),
    );
  }
}
