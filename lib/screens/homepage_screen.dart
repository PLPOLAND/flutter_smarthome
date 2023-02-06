import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/light.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/widgets/lightWidget.dart';
import 'package:provider/provider.dart';

import '../models/device.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = '/homepage';

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Device> devices = Provider.of<DevicesProvider>(context).devices;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Room 1"),
            Divider(),
            Container(
              height: 200,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  if (devices[index] is Light) {
                    return ChangeNotifierProvider.value(
                        value: devices[index] as Light, child: LightWidget());
                  } else {
                    return Container();
                  }
                },
                itemCount: devices.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
