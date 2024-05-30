import 'package:flutter_smarthome/models/automations/automation.dart';

class AutomaticAutomation extends Automation {
  //TODO: Conditions
  AutomaticAutomation({
    required super.id,
    required super.name,
    // required super.onClick,
    required super.icon,
    required super.actions,
    super.description,
  });
}
