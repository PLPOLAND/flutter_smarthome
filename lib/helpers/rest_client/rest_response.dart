import 'dart:convert';

class RestResponse {
  final int statusCode;
  final Map body;
  final String? error;

  RestResponse({required this.statusCode, required Map responseBody})
      : body =
            responseBody['obj'] == "" ? {} : json.decode(responseBody['obj']),
        error = responseBody['error'] as String?;

  bool get isOk => statusCode == 200 && (error == null || error == '');

  bool get isApiError => statusCode == 200 && error != null && error != '';

  @override
  String toString() {
    String tmp = '{';
    for (var el in body.entries) {
      tmp += '${el.key}: ${el.value}';
    }
    tmp += '}';

    return 'Response { statusCode: $statusCode, body: $tmp, error: $error }';
  }
}
