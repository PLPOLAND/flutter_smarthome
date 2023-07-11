import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';

class TestScreen extends StatelessWidget {
  static const routeName = '/test-screen';

  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    RESTClient().restartAllSlaves();
                  },
                  child: const Text('RestartAllSlaves'))
            ],
          ),
        ),
      ),
    );
  }
}
