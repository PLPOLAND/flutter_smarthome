import 'package:flutter/widgets.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/automations/function_action.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';

class ButtonAutomation extends Automation {
  final Button button;
  ButtonAutomation({
    required super.id,
    required super.name,
    required super.onClick,
    super.description,
    required super.icon,
    required super.actions,
    required this.button,
  });

  ButtonAutomation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    Function()? onClick,
    List<FunctionAction>? actions,
    Button? button,
  }) {
    return ButtonAutomation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      onClick: onClick ?? this.onClick,
      actions: actions ?? this.actions,
      button: button ?? this.button,
    );
  }
}
