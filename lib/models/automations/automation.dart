import 'package:flutter/widgets.dart';
import 'package:flutter_smarthome/models/automations/function_action.dart';

class Automation {
  final int id;
  final String name;
  final String? description;
  final IconData? icon;
  final Function() onClick;
  final List<FunctionAction> actions;

  const Automation({
    required this.id,
    required this.name,
    required this.onClick,
    this.description,
    required this.icon,
    required this.actions,
  });

  @override
  String toString() {
    return 'Automation{name: $name, description: $description, icon: $icon, onClick: $onClick, actions: $actions}';
  }

  Automation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    Function()? onClick,
    List<FunctionAction>? actions,
  }) {
    return Automation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      onClick: onClick ?? this.onClick,
      actions: actions ?? this.actions,
    );
  }
}
