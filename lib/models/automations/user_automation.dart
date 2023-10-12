import 'package:flutter/widgets.dart';
import 'package:flutter_smarthome/models/room.dart';

import 'automation.dart';

class UserAutomation extends Automation {
  final String userNickname; //nick użytkownika do którego należy automatyzacja

  const UserAutomation({
    required int id,
    required String name,
    required Function() onClick,
    required this.userNickname,
    String? description,
    IconData? icon,
  }) : super(
          id: id,
          name: name,
          onClick: onClick,
          description: description,
          icon: icon,
        );

  @override
  String toString() {
    return 'UserAutomation{userName: $userNickname,  super: ${super.toString()}';
  }

  @override
  UserAutomation copyWith({
    int? id,
    String? name,
    String? description,
    IconData? icon,
    Function()? onClick,
    String? userNickname,
  }) {
    return UserAutomation(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      onClick: onClick ?? this.onClick,
      userNickname: userNickname ?? this.userNickname,
    );
  }
}
