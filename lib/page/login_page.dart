import 'package:flutter/material.dart';
import 'package:flutter_api_ret/utils/responsive.dart';
import 'package:flutter_api_ret/widgest/circle.dart';
import 'package:flutter_api_ret/widgest/icon_container.dart';
import 'package:flutter_api_ret/widgest/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static const loginPage = 'LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -pinkSize * 0.4,
                  right: -pinkSize * 0.2,
                  child: Circle(
                    size: pinkSize,
                    colors: [
                      Colors.pinkAccent,
                      Colors.pink,
                    ],
                  ),
                ),
                Positioned(
                  top: -orangeSize * 0.55,
                  left: -orangeSize * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: [
                      Colors.orange,
                      Colors.deepOrangeAccent,
                    ],
                  ),
                ),
                Positioned(
                  top: responsive.hp(15),
                  child: Column(
                    children: [
                      IconContainer(size: responsive.wp(25)),
                      SizedBox(height: responsive.dp(2)),
                      Text(
                        "Hello again \n Welcome Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: responsive.dp(1.5)),
                      ),
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
