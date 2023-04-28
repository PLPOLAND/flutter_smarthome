class UserData {
  final String nickName;
  final String showName;
  final String email;
  final String token;
  final String? avatarFile;

  UserData(
      this.nickName, this.showName, this.email, this.token, this.avatarFile);

  const UserData.nullData()
      : nickName = '',
        showName = '',
        email = '',
        token = '',
        avatarFile = null;

  static UserData fromJson(Map body) {
    print(body);
    return UserData(
      body['nick'] as String, body['imie'] as String,
      body['email'] as String, body['token'] as String, null,
      // body['avatarFile'] as String?,
    );
  }

  @override
  String toString() {
    return 'UserData { nickName: $nickName, showName: $showName, email: $email, token: $token, avatarFile: $avatarFile }';
  }

  String toJson() {
    return '{ "nick": "$nickName", "imie": "$showName", "email": "$email", "token": "$token" }';
  }
}
