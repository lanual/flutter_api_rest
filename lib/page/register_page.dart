import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_api_ret/utils/responsive.dart';
import 'package:flutter_api_ret/widgest/avatar_button.dart';
import 'package:flutter_api_ret/widgest/circle.dart';
import 'package:flutter_api_ret/widgest/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  static const routeName = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(60);
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
                  top: -pinkSize * 0.20,
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
                  top: -orangeSize * 0.30,
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
                      //SizedBox(height: responsive.dp(2)),
                      Text(
                        "Hello again \n Sign up to get startet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsive.dp(1.5), color: Colors.white),
                      ),
                      SizedBox(
                        height: responsive.dp(1),
                      ),
                      AvatarButton(responsive: responsive),
                    ],
                  ),
                ),
                RegisterForm(),
                Positioned(
                  left: responsive.dp(1),
                  top: responsive.dp(1),
                  child: SafeArea(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.black26,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
