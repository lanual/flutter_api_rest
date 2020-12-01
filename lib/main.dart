import 'package:flutter/material.dart';
import 'package:flutter_api_ret/helpers/dependency_inyections.dart';
import 'package:flutter_api_ret/page/home_page.dart';
import 'package:flutter_api_ret/page/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_ret/page/register_page.dart';
import 'package:flutter_api_ret/page/splah_page.dart';

/*
API REST
--Crear Usuario
--Iniciar Session
--Obtener la info del Usuario Usando JWT
--RefresToken
--Actualizar Foto de perfil
*/

void main() {
  DependenciInyection.initializer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.loginPage: (_) => LoginPage(),
        HomePage.homePage: (_) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
