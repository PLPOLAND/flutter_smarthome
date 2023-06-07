import 'dart:convert';

class RestResponse<T> {
  final int statusCode;
  final T? body;
  final String? error;

  RestResponse({required this.statusCode, required Map responseBody})
      : body = responseBody['obj'] is Null ? null : responseBody['obj'] as T,
        error = responseBody['error'] as String?;

  bool get isOk => statusCode == 200 && (error == null || error == '');

  bool get isApiError => statusCode == 200 && error != null && error != '';

  @override
  String toString() {
    String tmp = '{';
    body.toString();
    tmp += '}';

    return 'Response { statusCode: $statusCode, body: $tmp, error: $error }';
  }
}
