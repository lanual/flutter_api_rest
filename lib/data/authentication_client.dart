import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_api_ret/api/authetication_api.dart';

import 'package:flutter_api_ret/models/authentication_response.dart';
import 'package:flutter_api_ret/models/session.dart';
import 'package:flutter_api_ret/page/login_page.dart';
import 'package:flutter_api_ret/utils/logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationApi _auth;

  AuthenticationClient(this._secureStorage, this._auth);
  Completer _completer;

  Future<String> accesToken(BuildContext context) async {
    final data = await _secureStorage.read(key: 'SESSION');
    String token;
    if (_completer != null) {
      await _completer.future;
    }

    Logs.p.i("CALLED ${DateTime.now()}");
    _completer = Completer();

    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      token = session.token;

      final DateTime currentDate = DateTime.now();
      final DateTime createAt = session.createAt;
      final int expireIn = session.expiresIn;

      final int diff = currentDate.difference(createAt).inSeconds;

      if (diff >= expireIn - 600) {
        //if (expireIn - diff >= 60) {
        final response = await _auth.refreshToken(session.token);

        Logs.p.i("status code  ${response.statusCode}");
        print(response.statusCode);
        if (response.statusCode == 200) {
          saveSession(response.data);
          token = response.data.token;
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginPage.loginPage, (_) => false);
        }
      }
    }
    _completer.complete();
    return token;
  }

  Future<void> saveSession(
      AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson());

    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> singOut() async {
    await _secureStorage.deleteAll();
  }
}
