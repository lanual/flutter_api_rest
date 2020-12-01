import 'package:dio/dio.dart';
import 'package:flutter_api_ret/helpers/http_response.dart';
import 'package:flutter_api_ret/utils/logs.dart';

import 'package:meta/meta.dart' show required;

class Http {
  Dio _dio;
  bool _enabledLogger;

  Http({
    @required dio,
    @required enabledLogger,
  }) {
    _dio = dio;

    _enabledLogger = enabledLogger;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    Map<String, String> headers,
    Map<String, dynamic> body,
    Map<String, dynamic> formData,
    Map<String, dynamic> queryParameters,
    String method = 'Get',
    T Function(dynamic data) parser,
  }) async {
    Response response;
    try {
      Logs.p.i(path);

      response = await _dio.request(
        path,
        options: Options(
          headers: headers,
          method: method,
        ),
        data: formData == null ? body : FormData.fromMap(formData),
        queryParameters: queryParameters,
      );
    } on DioError catch (e) {
      int statusCode = -1;
      String message;
      dynamic data;

      message = e.message;
      data = e.error;

      if (e.response != null) {
        statusCode = e.response.statusCode;
        message = e.response.statusMessage;
        data = e.response.data;
      }

      return HttpResponse.fail<T>(
        data: data,
        message: message,
        statusCode: statusCode,
      );
    } catch (e) {
      return HttpResponse.fail<T>(
          data: null, message: 'Error Inesperado', statusCode: 0);
    }
    Logs.p.i(response.data);
    if (parser != null) {
      return HttpResponse.sucess<T>(
          data: parser(response.data), statusCode: response.statusCode);
    }

    return HttpResponse.sucess<T>(
        data: response.data, statusCode: response.statusCode);
  }
}
