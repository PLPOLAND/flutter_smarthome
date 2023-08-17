import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_smarthome/models/bloc/lan_scanner/lan_scanner_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/rest_client/rest_client.dart';
import '../../models/bloc/auth/auth_bloc.dart';
import '../home/homepage_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _ipTextController = TextEditingController();

  List<String> servers = [];

  String currentNickname = '';
  String currentPassword = '';
  String currentIp = '';

  var scanning = true;
  var ipOk = false;

  @override
  void initState() {
    super.initState();
    scanning = true;
  }

  Future<void> checkIfProvidedIpIsOk(String val) async {
    if (val.isNotEmpty &&
        RegExp(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$").hasMatch(val)) {
      await RESTClient().checkServer(val).then((value) {
        setState(() {
          ipOk = value;
        });
      });
    }
  }

  /// returns a form field for the server address if no servers are found, otherwise a dropdown menu with the found servers
  get serverFormWidget {
    return BlocConsumer<LanScannerBloc, LanScannerState>(
      listener: (context, state) {
        if (state.status == ScannnerStatus.done) {
          // setState(() {
          scanning = false;
          servers = state.servers;
          // });
          if (state.servers.isEmpty) {
            // if no servers were found, show a snackbar to inform the user to enter the server address manually
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Didn't find any servers. Please enter the server address manually.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
        if (state.status == ScannnerStatus.found) {
          // setState(() {
          if (servers.isEmpty) {
            currentIp = state.servers.first;
          }
          servers =
              state.servers; // add the found server to the list of servers
          // });
        }
      },
      buildWhen: (previous, current) =>
          current.status == ScannnerStatus.done ||
          current.status == ScannnerStatus.found,
      builder: (context, state) {
        if (state.servers.isEmpty) {
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _ipTextController,
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter a server address';
                    } else if (!RegExp(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$")
                        .hasMatch(val)) {
                      return 'Please enter a valid server address';
                    }
                    setState(() {
                      ipOk = true;
                    });
                    return null;
                  },
                  onSaved: (val) async {
                    if (val != null) {
                      await checkIfProvidedIpIsOk(val);
                    }
                  },
                  onFieldSubmitted: (val) async {
                    await checkIfProvidedIpIsOk(val);
                  },
                  onTapOutside: (event) async {
                    var val = _ipTextController.text;
                    await checkIfProvidedIpIsOk(val);
                  },
                  onChanged: (val) async {
                    if (ipOk) {
                      setState(() {
                        ipOk = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Server',
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    hintText: "xxx.xxx.xxx.xxx",
                    prefixIcon: Icon(
                      Icons.router,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    suffixIcon: ipOk
                        ? Icon(
                            Icons.done,
                            color: Colors.green.harmonizeWith(
                              Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (scanning) const SizedBox(width: 10),
              if (scanning) const CircularProgressIndicator(),
            ],
          );
        } else {
          return DropdownButtonFormField(
            items: state.servers
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
            value: state.servers.isNotEmpty ? state.servers.first : null,
            onChanged: (val) {
              currentIp = val.toString();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacementNamed(HomepageScreen.routeName);
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Auth Screen'),
        // ),
        body: BlocProvider.value(
          value: LanScannerBloc()..add(LanScannerStart()),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
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
                          //NickName Field
                          TextFormField(
                            textInputAction: TextInputAction.next,
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
                              } else if (value.contains(RegExp("  *"))) {
                                return 'Nickname can\'t contain spaces';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              currentNickname = value ?? '';
                            },
                          ),
                          const SizedBox(height: 10),
                          //Password Field
                          TextFormField(
                            textInputAction: TextInputAction.done,
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
                                  child: BlocConsumer<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state.status.isError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('${state.errorMessage}'),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state.status == AuthStatus.loading) {
                                        return LinearProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        );
                                      } else if (state.status.isAuthenticated) {
                                        return const Icon(Icons.done);
                                      } else {
                                        return const Text('Login');
                                      }
                                    },
                                  ),
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
                                            title: const Text(
                                                'Password forgotten'),
                                            content: const Text(
                                                'Not implemented yet'),
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
        ),
      ),
    );
  }

  void login() async {
    _form.currentState!.save();
    if (!_form.currentState!.validate()) {
      return; // Invalid!
    }
    if (servers.isEmpty) {
      if (!ipOk) {
        if (await RESTClient().checkServer(_ipTextController.text)) {
          ipOk = true;
          currentIp = _ipTextController.text;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Server not found'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          return;
        }
        return;
      } else {
        currentIp = _ipTextController.text;
      }
    }
    RESTClient().setIP(currentIp);
    try {
      if (context.mounted) {
        context.read<AuthBloc>().add(
              LogIn(email: currentNickname, password: currentPassword),
            );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
