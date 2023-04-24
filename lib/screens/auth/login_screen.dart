import 'package:flutter/material.dart';

import '../../models/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  List<String> servers = [];

  String currentNickname = '';
  String currentPassword = '';

  @override
  void initState() {
    super.initState();
    // Auth().scanForServer().listen((event) {
    //   setState(() {
    //     servers.add(event);
    //   });
    // });
  }

  /// returns a form field for the server address if no servers are found, otherwise a dropdown menu with the found servers
  get serverFormWidget {
    if (servers.isEmpty) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Server',
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          hintText: "xxx.xxx.xxx.xxx",
          prefixIcon: Icon(
            Icons.router,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return 'Please enter a server address';
          } else if (!RegExp(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$")
              .hasMatch(val)) {
            return 'Please enter a valid server address';
          }
          return null;
        },
        onSaved: (val) {
          currentNickname = val!;
        },
      );
    } else {
      return DropdownButtonFormField(
        items: servers
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          labelText: 'Server',
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          prefixIcon: Icon(
            Icons.router,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value: servers.isNotEmpty ? servers.first : null,
        onChanged: (val) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Auth Screen'),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
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
                  key: _form,
                  child: Column(
                    children: [
                      serverFormWidget,
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nickname',
                          labelStyle: Theme.of(context).textTheme.bodyLarge,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a nickname';
                          } else if (value.startsWith(RegExp(r'[0-9]'))) {
                            return 'Nickname can\'t start with a number';
                          } else if (value.length < 3) {
                            return 'Nickname must be at least 3 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          currentNickname = value ?? '';
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: Theme.of(context).textTheme.bodyLarge,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          currentPassword = value ?? '';
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: login,
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                //TODO: Implement password forgotten
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Password forgotten'),
                                        content:
                                            const Text('Not implemented yet'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Text('Password forgotten?'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    _form.currentState!.save();
    if (!_form.currentState!.validate()) {
      return; // Invalid!
    }
  }
}
