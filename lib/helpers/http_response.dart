import 'package:meta/meta.dart' show required;

class HttpResponse<T> {
  final T data;
  final int statusCode;
  final HttpError httpError;

  HttpResponse({this.data, this.httpError, this.statusCode});

  static HttpResponse<T> sucess<T>({
    @required T data,
    @required int statusCode,
  }) =>
      HttpResponse(
        data: data,
        httpError: null,
        statusCode: statusCode,
      );

  static HttpResponse<T> fail<T>({
    @required T data,
    @required String message,
    @required int statusCode,
  }) =>
      HttpResponse(
        data: null,
        statusCode: statusCode,
        httpError: HttpError(
          data: data,
          message: message,
          statusCode: statusCode,
        ),
      );
}

class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({
    @required this.data,
    @required this.message,
    @required this.statusCode,
  });
}
