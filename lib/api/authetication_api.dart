import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_api_ret/helpers/http.dart';
import 'package:flutter_api_ret/helpers/http_response.dart';
import 'package:flutter_api_ret/models/authentication_response.dart';
import 'package:flutter_api_ret/models/user.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<HttpResponse> register({
    @required emil,
    @required password,
    @required username,
  }) async {
    return await _http.request(
      '/api/v1/register',
      headers: {'Content-Type': 'application/json'},
      method: 'POST',
      body: {
        "username": username,
        "email": emil,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse> login({
    @required emil,
    @required password,
  }) async {
    return await _http.request(
      '/api/v1/login',
      headers: {'Content-Type': 'application/json'},
      method: 'POST',
      body: {
        "email": emil,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse> getUserInfo(String token) async {
    return await _http.request(
      '/api/v1/user-info',
      headers: {'token': token},
      method: 'GET',
      parser: (data) {
        return User.fromJson(data);
      },
    );
  }

  Future<HttpResponse> refreshToken(String expiredToken) async {
    return await _http.request(
      '/api/v1/refresh-token',
      headers: {'token': expiredToken},
      method: 'POST',
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<String>> updaTeAvatar(
    String token,
    String fileName,
    Uint8List bytes,
  ) async {
    return await _http.request(
      '/api/v1/update-avatar',
      headers: {'token': token},
      method: 'POST',
      formData: {
        'attachment': MultipartFile.fromBytes(
          bytes,
          filename: fileName,
        ),
      },
    );
  }
}
