import 'package:flutter/widgets.dart';
import 'package:flutter_smarthome/models/automations/function_action.dart';
import 'package:flutter_smarthome/models/room.dart';

import 'automation.dart';

class UserAutomation extends Automation {
  final int userID; //nick użytkownika do którego należy automatyzacja

  const UserAutomation({
    required int id,
    required String name,
    // required Function() onClick,
    required this.userID,
    String? description,
    IconData? icon,
    required List<FunctionAction> actions,
    bool active = false,
  }) : super(
          id: id,
          name: name,
          // onClick: onClick,
          description: description,
          icon: icon,
          actions: actions,
          active: active,
        );

  @override
  String toString() {
    return 'UserAutomation{userID: $userID,  super: ${super.toString()}';
  }

  @override
  UserAutomation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    // Function()? onClick,
    int? userID,
    List<FunctionAction>? actions,
    bool? active,
  }) {
    return UserAutomation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      // onClick: onClick ?? this.onClick,
      actions: actions ?? this.actions,
      userID: userID ?? this.userID,
      active: active ?? this.active,
    );
  }
}
