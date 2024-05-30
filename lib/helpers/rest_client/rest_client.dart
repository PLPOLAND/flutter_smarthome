import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_smarthome/models/auth/user_data.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/automations/button_automation.dart';
import 'package:flutter_smarthome/models/sensors/hygro_termometer.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/motion.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:flutter_smarthome/models/sensors/twilight.dart';
import 'package:flutter_smarthome/screens/sensors_screen.dart';
import '../../models/devices/blind.dart';
import '../../models/devices/device.dart';
import '../../models/devices/fan.dart';
import '../../models/devices/light.dart';
import '../../models/devices/outlet.dart';
import '../../models/room.dart';
import '../../models/sensors/button.dart';
import '../../models/sensors/sensor.dart';
import 'rest_response.dart';

class RESTClient {
  String _ip;
  Dio _dio;
  UserData? _userData;

  static final RESTClient _singleton = RESTClient._internal();

  factory RESTClient() {
    return _singleton;
  }

  RESTClient._internal()
      : _dio = Dio(),
        _ip = '';

  /// The function sets the value of a variable called "ip" to a given string.
  void setIP(String ip) {
    _ip = ip;
  }

  /// The function returns the value of a variable called "ip".
  String getIP() {
    return _ip;
  }

  bool isIPSet() {
    return _ip.isNotEmpty;
  }

  UserData? getLocalUserData() {
    return _userData;
  }

  bool isUserDataSet() {
    return _userData != null;
  }

  void setUserData(UserData? userData) {
    _userData = userData;
  }

  /// Scans the local network for a server
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
      var response = await _dio.get('http://$ip:8080/api/homeData',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            sendTimeout: const Duration(milliseconds: 100),
            // receiveTimeout: Duration(milliseconds: 100),
          ));
      if (response.statusCode == 200) {
        // log(response.data);
        if (response.data == 'hello') {
          return true;
        }
      }
    } on Exception catch (_) {
      // log('Error $ip');
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
    var response = await _dio.post(
      'http://$_ip:8080/api/login',
      data: {
        'nick': nick,
        'pass': password,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse<Map> res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data,
    );
    // log(res.toString());
    if (res.isOk) {
      return res.body!['token'];
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
    var response = await _dio.post(
      'http://$_ip:8080/api/getUserData',
      data: {
        'token': token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse<String> res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data,
    );
    // log(res.toString());
    if (res.isOk) {
      return UserData.fromJson(jsonDecode(res.body!));
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<List<Device>> getDevices() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.get(
      'http://$_ip:8080/api/getDevices?token=${_userData?.token}',
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      List<Device> devices = [];
      for (var device in res.body) {
        switch (device['typ']) {
          case 'LIGHT':
            devices.add(Light.fromJson(device));
            break;
          case 'BLIND':
            devices.add(Blind.fromJson(device));
            break;
          case 'WENTYLATOR':
            devices.add(Fan.fromJson(device));
            break;
          case 'GNIAZDKO':
            devices.add(Outlet.fromJson(device));
            break;
          default:
            log("Error: Unknown device type");
        }
      }
      return devices;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<List<Sensor>> getSensors() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.get(
      'http://$_ip:8080/api/getSensors',
      queryParameters: {
        'token': _userData?.token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      List<Sensor> sensors = [];
      for (var sensor in res.body) {
        switch (sensor['typ']) {
          case 'THERMOMETR':
            sensors.add(Thermometer.fromJson(sensor));
            break;
          case 'THERMOMETR_HYGROMETR':
            sensors.add(HygroThermometer.fromJson(sensor));
            break;
          case 'TWILIGHT':
            break;
          case 'MOTION':
            break;
          case 'BUTTON':
            sensors.add(Button.fromJson(sensor));
            break;
          default:
            log("Error: Unknown device type");
        }
      }
      return sensors;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<List<Room>> getRooms() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.get(
      'http://$_ip:8080/api/getRooms',
      queryParameters: {
        'token': _userData?.token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      List<Room> rooms = [];
      for (var room in res.body) {
        rooms.add(Room.fromJson(room));
      }
      // log(rooms.toString());
      return rooms;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<String> getFavoriteRooms() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.get(
      'http://$_ip:8080/api/getFavoriteRooms',
      queryParameters: {
        'token': _userData?.token,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      return res.body;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<String> addFavoriteRoom(int roomID) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.post(
      'http://$_ip:8080/api/addFavoriteRoom',
      data: {
        'token': _userData?.token,
        'roomId': roomID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      return res.body;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  Future<String> removeFavoriteRoom(int roomID) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    var response = await _dio.post(
      'http://$_ip:8080/api/removeFavoriteRoom',
      data: {
        'token': _userData?.token,
        'roomId': roomID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    RestResponse res = RestResponse(
      statusCode: response.statusCode ?? 0,
      responseBody: response.data ?? {},
    );
    // log(res.toString());
    if (res.isOk) {
      return res.body;
    } else if (res.isApiError) {
      throw Exception(res.error);
    } else {
      throw Exception('Unknown error, status code: ${res.statusCode}');
    }
  }

  //TODO exception handling for all methods
  Future<void> changeDeviceState({
    required int deviceId,
    required DeviceState state,
  }) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/changeDeviceState',
        data: {
          'token': _userData?.token,
          'deviceId': deviceId,
          'state': state,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );
      // log(res.toString());
      if (res.isOk) {
        return;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> getDevicesState() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.get(
        'http://$_ip:8080/api/getDevicesState',
        queryParameters: {
          'token': _userData?.token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      // if (response.data['error'] != null) {
      //   List<dynamic> resp = response.data['obj'];
      //   List<String> devicesState = [];

      // }
      RestResponse<dynamic> res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );
      // log(res.toString());
      if (res.isOk) {
        List<dynamic> resp = res.body;
        List<Map<String, dynamic>> devicesStates =
            resp.map((e) => e as Map<String, dynamic>).toList();
        return devicesStates;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  /// The function adds a new device to the database. It sends a request to the server.
  Future<Device> addDevice(
      {required int roomID,
      required DeviceType deviceType,
      required int slaveID,
      required String name,
      required int pin,
      int? pinDown}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/addDevice',
        data: deviceType != DeviceType.blind
            ? {
                'token': _userData?.token,
                'roomID': roomID,
                'type': deviceType.toString(),
                'slaveID': slaveID,
                'name': name,
                'pin': pin,
              }
            : {
                'token': _userData?.token,
                'roomID': roomID,
                'type': deviceType.toString(),
                'slaveID': slaveID,
                'name': name,
                'pin': pin,
                'pin2': pinDown,
              },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        switch (deviceType) {
          case DeviceType.light:
            return Light.fromJson(res.body);
          case DeviceType.blind:
            return Blind.fromJson(res.body);
          case DeviceType.fan:
            return Fan.fromJson(res.body);
          case DeviceType.outlet:
            return Outlet.fromJson(res.body);
          default:
            throw Exception('Unknown device type');
        }
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  /// The function deletes a device from the database. It sends a request to the server.
  /// Returns [true] if device was deleted
  /// Returns [false] if device was not deleted
  /// Throws [Exception] if error occured

  Future<bool> deleteDevice({required int deviceID}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/removeDevice',
        data: {
          'token': _userData?.token,
          'deviceId': deviceID,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        return res.body as String == 'OK';
      } else if (res.isApiError) {
        return false;
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<void> updateDevice(
      {required int deviceID,
      String? name,
      int? slaveId,
      int? room,
      int? pin,
      int? pinDown}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      Map<String, Object?> data = {
        'token': _userData?.token,
        'deviceId': deviceID,
      };
      if (name != null) {
        data['name'] = name;
      }
      if (slaveId != null) {
        data['slaveId'] = slaveId;
      }
      if (room != null) {
        data['room'] = room;
      }
      if (pin != null) {
        data['pin'] = pin;
      }
      if (pinDown != null) {
        data['pin2'] = pinDown;
      }

      var response = await _dio.post(
        'http://$_ip:8080/api/updateDevice',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        return;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<Device> getDevice(int deviceID) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.get(
        'http://$_ip:8080/api/getDevice',
        queryParameters: {
          'token': _userData?.token,
          'deviceId': deviceID,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        switch (res.body['typ']) {
          case 'LIGHT':
            return Light.fromJson(res.body);
          case 'BLIND':
            return Blind.fromJson(res.body);
          case 'WENTYLATOR':
            return Fan.fromJson(res.body);
          case 'GNIAZDKO':
            return Outlet.fromJson(res.body);
          default:
            throw Exception('Unknown device type');
        }
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> getSensorsState() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.get(
        'http://$_ip:8080/api/getSensorsState',
        queryParameters: {
          'token': _userData?.token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      RestResponse<dynamic> res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );
      // log(res.toString());
      if (res.isOk) {
        List<dynamic> resp = res.body;
        List<Map<String, dynamic>> sensorsStates =
            resp.map((e) => e as Map<String, dynamic>).toList();
        return sensorsStates;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<Sensor> addSensor({required Sensor sensor}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    Map<String, Object?> dataToSend;
    switch (sensor.type) {
      case SensorType.button:
        dataToSend = {
          'token': _userData?.token,
          'roomID': sensor.roomId,
          'type': sensor.type,
          'slaveID': sensor.slaveID,
          'onSlaveID': (sensor as Button).onSlaveID,
          'name': sensor.name,
          'pin': sensor.onSlavePin,
          'funkcjeKlikniec':
              jsonEncode(sensor.localFunctions.map((e) => e.toJson()).toList()),
        };
        break;
      case SensorType.thermometer:
      case SensorType.hygrometer:
        dataToSend = {
          'token': _userData?.token,
          'roomID': sensor.roomId,
          'slaveID': sensor.slaveID,
          'name': sensor.name,
          'type': sensor.type.toString(),
          'adress': sensor.adress,
        };
        break;
      case SensorType.hygroThermometer:
        dataToSend = {
          'token': _userData?.token,
          'roomID': sensor.roomId,
          'slaveID': sensor.slaveID,
          'name': sensor.name,
          'type': sensor.type.toString(),
        };
        break;
      case SensorType.motion:
        dataToSend = {
          'token': _userData?.token,
          'roomID': sensor.roomId,
          'slaveID': sensor.slaveID,
          'name': sensor.name,
          'type': sensor.type.toString(),
          'pin': (sensor as Motion).onSlavePin,
        };
        break;
      case SensorType.twilight:
        dataToSend = {
          'token': _userData?.token,
          'roomID': sensor.roomId,
          'slaveID': sensor.slaveID,
          'name': sensor.name,
          'type': sensor.type.toString(),
          'pin': (sensor as Twilight).onSlavePin,
        };
        break;
      default:
        throw Exception('Unknown sensor type');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/addSensor',
        data: dataToSend,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        switch (sensor.type) {
          case SensorType.button:
            return Button.fromJson(res.body);
          case SensorType.thermometer:
            return Thermometer.fromJson(res.body);
          case SensorType.hygrometer:
            return Hygrometer.fromJson(res.body);
          case SensorType.hygroThermometer:
            return HygroThermometer.fromJson(res.body);
          case SensorType.motion:
            return Motion.fromJson(res.body);
          case SensorType.twilight:
            return Twilight.fromJson(res.body);
          default:
            throw Exception('Unknown device type');
        }
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  //TODO delete sensor
  Future<bool> removeSensor({required int sensorID}) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/removeSensor',
        data: {
          'token': _userData?.token,
          'id': sensorID,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        return res.body as bool;
      } else if (res.isApiError) {
        return false;
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  //TODO update sensor
  Future<void> updateSensor({
    required int sensorID,
    String? name,
    int? slaveId,
    int? roomId,
    int? pin,
    List<ButtonLocalClickFunction>? localFunctions,
  }) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }

    try {
      Map<String, Object?> data = {
        'token': _userData?.token,
        'id': sensorID,
      };
      if (name != null) {
        data['name'] = name;
      }
      if (slaveId != null) {
        data['slaveId'] = slaveId;
      }
      if (roomId != null) {
        data['room'] = roomId;
      }
      if (pin != null) {
        data['pin'] = pin;
      }
      if (localFunctions != null) {
        data['funkcjeKlikniec'] =
            jsonEncode(localFunctions.map((e) => e.toJson()).toList());
      }

      var response = await _dio.post(
        'http://$_ip:8080/api/updateSensor',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      // log(res.toString());

      if (res.isOk) {
        return;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<void> restartAllSlaves() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/restartAllSlaves',
        data: {
          'token': _userData?.token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      RestResponse res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );
      // log(res.toString());
      if (res.isOk) {
        return;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  Future<List<Automation>> getAutomations() async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.get(
        'http://$_ip:8080/api/getAutomations',
        queryParameters: {
          'token': _userData?.token,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse<List<dynamic>> res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      log(res.toString());

      if (res.isOk) {
        List<Automation> automations = [];
        for (Map<String, dynamic> automationData in res.body!) {
          switch (automationData['type']) {
            case 'BUTTON':
              automations.add(ButtonAutomation.fromJson(automationData));
              break;
            default:
              throw Exception(
                  'Unknown automation type: ${automationData['typ']}');
          }
        }
        return automations;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }

  void runFunction(int id) async {
    if (!isIPSet()) {
      throw Exception('IP not set');
    }
    try {
      var response = await _dio.post(
        'http://$_ip:8080/api/runAutomation',
        queryParameters: {
          'token': _userData?.token,
          'id': id,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      RestResponse<String> res = RestResponse(
        statusCode: response.statusCode ?? 0,
        responseBody: response.data ?? {},
      );

      if (res.isOk) {
        return;
      } else if (res.isApiError) {
        throw Exception(res.error);
      } else {
        throw Exception('Unknown error, status code: ${res.statusCode}');
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Unknown error, status code: ${e.response?.statusCode}');
    }
  }
}
