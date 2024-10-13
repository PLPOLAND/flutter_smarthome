import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/automations/function_action.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';

class ButtonAutomation extends Automation {
  final Button button;
  ButtonAutomation({
    required super.id,
    required super.name,
    // required super.onClick,
    super.description,
    super.icon,
    required super.actions,
    required this.button,
    super.active = false,
  });

  @override
  ButtonAutomation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    Function()? onClick,
    List<FunctionAction>? actions,
    Button? button,
    bool? active,
  }) {
    return ButtonAutomation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      // onClick: onClick ?? this.onClick,
      actions: actions ?? this.actions,
      button: button ?? this.button,
      active: active ?? this.active,
    );
  }

  static Automation fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return ButtonAutomation(
      id: json['id'],
      name: json['name'],
      // onClick: () {},
      actions: (json['actions'] as List<dynamic>)
          .map<FunctionAction>((e) => FunctionAction.fromJson(e))
          .toList(),
      button: Button.fromJson(json['button']),
      active: json['active'],
    );
  }
}
