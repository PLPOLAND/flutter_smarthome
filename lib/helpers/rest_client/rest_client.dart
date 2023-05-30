import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_smarthome/models/auth/user_data.dart';
import 'rest_response.dart';

class RESTClient {
  String ip;
  Dio dio;

  static final RESTClient _singleton = RESTClient._internal();

  factory RESTClient() {
    return _singleton;
  }

  RESTClient._internal()
      : dio = Dio(),
        ip = '';

  /// The function sets the value of a variable called "ip" to a given string.
  void setIP(String ip) {
    this.ip = ip;
  }

  /// The function returns the value of a variable called "ip".
  String getIP() {
    return ip;
  }

  bool isIPSet() {
    return ip.isNotEmpty;
  }

  Stream<String> scanForServer() async* {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 100),
      ),
    ); // local dio instance for quicker scan because of timeout
    String ip = '';
    // print('Scanning for servers...');
    for (var i = 2; i < 255; i++) {
      try {
        // print('Trying 192.168.1.$i');
        var response = await dio.get('http://192.168.1.$i:8080/api/homeData',
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              sendTimeout: const Duration(milliseconds: 100),
              // receiveTimeout: Duration(milliseconds: 100),
            ));
        if (response.statusCode == 200) {
          // print(response.data);
          if (response.data == 'hello') {
            // print('Found server at 192.168.1.$i');
            ip = '192.168.1.$i';
            yield ip;
          }
        }
      } on Exception catch (_) {
        // print('Error 192.168.1.$i');
      }
    }
  }

  /// Checks if server at [ip] is online
  /// returns [true] if server is online
  Future<bool> checkServer(String ip) async {
    try {
      // print('Trying 192.168.1.$i');
      var response = await dio.get('http://$ip:8080/api/homeData',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            sendTimeout: const Duration(milliseconds: 100),
            // receiveTimeout: Duration(milliseconds: 100),
          ));
      if (response.statusCode == 200) {
        log(response.data);
        if (response.data == 'hello') {
          return true;
        }
      }
    } on Exception catch (_) {
      log('Error $ip');
      return false;
    }
    return false;
  }

  Future<String> logIn({
    required String nick,
    required String password,
  }) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
      // TODO: handle exception. make custom exception
    }
    var response = await dio.post(
      'http://$ip:8080/api/login',
      data: {
        'nick': nick,
        'pass': password,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data,
    );
    log(res.toString());
    if (res.isOk) {
      return res.body['token'] as String;
    } else if (res.isApiError) {
      throw Exception(res.error); //TODO make custom exception
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<UserData> getUserData({required String token}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
      // TODO: handle exception, make custom exception
    }
    var response = await dio.post(
      'http://$ip:8080/api/getUserData',
      data: {
        'token': token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data,
    );
    log(res.toString());
    if (res.isOk) {
      return UserData.fromJson(res.body);
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }
}
