import 'package:http/http.dart' as http;

class Auth {
  String ip = '';

  void scanForServer() async {
    for (var i = 2; i < 255; i++) {
      scanTheIp(i).then((value) {
        if (value) {
          ip = '192.168.1.$i';
          print('Found server at 192.168.1.$i');
        }
      });
    }
  }

  Future<bool> scanTheIp(int i) async {
    try {
      // print('Trying 192.168.1.$i');
      var response =
          await http.get(Uri.parse('http://192.168.1.$i:8080/api/hello'));
      if (response.statusCode == 200) {
        if (response.body == 'hello') return true;
      }
    } on Exception catch (_) {
      return false;
    }
    return false;
  }
}
