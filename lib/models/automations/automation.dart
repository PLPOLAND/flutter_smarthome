import 'package:flutter/widgets.dart';

class Automation {
  final int id;
  final String name;
  final String? description;
  final IconData? icon;
  final Function() onClick;

  const Automation({
    required this.id,
    required this.name,
    required this.onClick,
    this.description,
    required this.icon,
  });

  @override
  String toString() {
    return 'Automation{name: $name, description: $description, icon: $icon, onClick: $onClick}';
  }

  Automation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    Function()? onClick,
  }) {
    return Automation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      onClick: onClick ?? this.onClick,
    );
  }
}
