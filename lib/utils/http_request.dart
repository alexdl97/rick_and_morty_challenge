import 'package:dio/dio.dart';

class JHttpRequest {
  final dio = Dio();
  static final JHttpRequest _singleton = JHttpRequest._internal();
  factory JHttpRequest() {
    return _singleton;
  }
  JHttpRequest._internal();

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json'
  };

  Future<JResponse> getRequest(String url,
      {Map<String, String> headers = defaultHeaders,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params}) async {
    final response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
      queryParameters: params,
    );
    return JResponse(statusCode: response.statusCode, data: response.data);
  }
}

class JResponse {
  final int? statusCode;
  final dynamic data;
  JResponse({this.statusCode = 500, required this.data});
}

class HttpCode {
  static const ok = 200;
  static const created = 201;
  static const errorServer = 500;
  static const badRequest = 400;
  static const notFound = 400;
}
