import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/auth/auth.dart';
import 'package:flutter_smarthome/screens/auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/auth';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const Text('SmartHome icon'),
                  )),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome!',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 10),
                    const Text('Please login or open demo mode!'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName);
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Auth().scanForServer();
                      },
                      child: const Text('Demo mode'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
