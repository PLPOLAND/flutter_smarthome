import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Auth Screen'),
      // ),
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(height: 10),
            Form(
                child: Column(children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nickname',
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ])),
          ]),
        ),
      )),
    );
  }
}
