import 'package:dio/dio.dart';
import 'package:flutter_api_ret/api/authetication_api.dart';
import 'package:flutter_api_ret/data/authentication_client.dart';
import 'package:flutter_api_ret/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependenciInyection {
  static void initializer() {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'),
    );

    final enabledLogger = true;
    final http = Http(dio: dio, enabledLogger: enabledLogger);
    final getIt = GetIt.instance;
    final secureStorage = FlutterSecureStorage();
    final auth = AuthenticationApi(http);
    final authenticationClient = AuthenticationClient(secureStorage, auth);

    getIt.registerSingleton<AuthenticationApi>(auth);
    getIt.registerSingleton<AuthenticationClient>(authenticationClient);
  }
}
