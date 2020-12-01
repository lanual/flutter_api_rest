import 'package:flutter/material.dart';
import 'package:flutter_api_ret/data/authentication_client.dart';
import 'package:flutter_api_ret/page/home_page.dart';
import 'package:flutter_api_ret/page/login_page.dart';
import 'package:flutter_api_ret/utils/logs.dart';

import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final token = await _authenticationClient.accesToken(context);
    Logs.p.i("TOKEN SPLASH ART  $token");
    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginPage.loginPage);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
