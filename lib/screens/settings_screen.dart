import 'package:flutter/material.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/themes/themes.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/settingsWidgets/settings_title.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  SettingsScreen({super.key});
  final TextEditingController _IPController = TextEditingController();
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<String> getServerIP() async {
    return RESTClient().getIP() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SettingsTitle("Server Settings"),
            ListTile(
              title: const Text('Server IP'),
              subtitle: FutureBuilder(
                future: getServerIP(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    widget._IPController.text = snapshot.data ?? "";
                    return Text(snapshot.data == ""
                        ? "No IP set"
                        : snapshot.data ?? "No IP set");
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
              // trailing: IconButton(
              //   icon: const Icon(Icons.edit),
              //   onPressed: () {
              //     // showIPEditingDialog(context, widget._IPController);
              //   },
              // ),
            ),
            const SettingsTitle("User Settings"),
            context.read<ThemesMenager>().getSettingsRow(context),
            //TODO add other settings etc.
            const SettingsTitle("About"),
            InkWell(
              onTap: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                showAboutDialog(
                    context: context,
                    applicationName: "SmartHome",
                    applicationVersion:
                        "version: ${packageInfo.version}+${packageInfo.buildNumber}",
                    applicationLegalese: "© 2023, Marek Pałdyna aka PLPOLAND",
                    applicationIcon: const Icon(Icons.home));
              },
              child: const ListTile(
                title: Text('About'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showIPEditingDialog(
      BuildContext context, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              insetPadding: const EdgeInsets.all(20),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text("Server IP"),
                        hintText: "xxx.xxx.xxx.xxx",
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        //TODO Validate IP
                        Navigator.of(context).pop(controller.text);
                      }),
                ),
              ],
            )).then((value) {
      if (value != null) {
        controller.text = value;
        getServerIP().then((value) {
          //check if the IP has changed before saving
          if (value != controller.text) {
            setState(() {}); //update the subtitle of the list tile
            SharedPreferences.getInstance().then((prefs) {
              prefs.setString('serverIP', controller.text);
            });
          }
        });
      }
    });
  }
}
