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
}
