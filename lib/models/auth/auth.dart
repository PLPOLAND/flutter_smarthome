import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Auth {
  String ip = '';
  Dio dio = Dio(BaseOptions(
    connectTimeout: Duration(milliseconds: 100),
  ));

  Stream<String> scanForServer() async* {
    print('Scanning for servers...');
    for (var i = 2; i < 255; i++) {
      try {
        // print('Trying 192.168.1.$i');
        var response = await dio.get('http://192.168.1.$i:8080/api/hello',
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              sendTimeout: Duration(milliseconds: 100),
              // receiveTimeout: Duration(milliseconds: 100),
            ));
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data == 'hello') {
            print('Found server at 192.168.1.$i');
            ip = '192.168.1.$i';
            yield ip;
          }
        }
      } on Exception catch (_) {
        print('Error 192.168.1.$i');
      }
    }
  }

  // Future<String> scanTheIp(int i) async {
  // return false;
  // }
}
