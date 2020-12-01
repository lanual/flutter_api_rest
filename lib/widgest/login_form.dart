import 'package:flutter/material.dart';
import 'package:flutter_api_ret/api/authetication_api.dart';
import 'package:flutter_api_ret/data/authentication_client.dart';
import 'package:flutter_api_ret/helpers/http_response.dart';
import 'package:flutter_api_ret/models/authentication_response.dart';
import 'package:flutter_api_ret/page/home_page.dart';
import 'package:flutter_api_ret/utils/progress_dialog.dart';
import 'package:flutter_api_ret/utils/responsive.dart';
import 'package:flutter_api_ret/widgest/input_text.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password;

  final _auth = GetIt.instance<AuthenticationApi>();

  /*NOTA ES MEJOR USAR UN GESTOR DE ESTADOS, PROVIDER, BLOC O GETX */
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  Future<void> _submit() async {
    final bool isValidForm = _formKey.currentState.validate();

    if (isValidForm) {
      ProgressDialog.show(context);

      final response = await _auth.login(emil: _email, password: _password);

      String message = "Incidente";
      if (response.statusCode == 200) {
        await _authenticationClient.saveSession(response.data);
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.homePage, (route) => false);

        return;
      } else {
        message = response.httpError.data['message'];
      }
      ProgressDialog.dismiss(context);
      Dialogs.alert(
        context,
        title: 'Incidente',
        description: message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 330,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                labelText: 'Email Adress',
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                onChanged: (value) {
                  _email = value;
                },
                validator: (value) {
                  if (!value.contains('@')) return 'Invalid Email';

                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        labelText: 'Password',
                        keyboardType: TextInputType.text,
                        oscure: true,
                        isBorder: false,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value.trim().length == 0)
                            return 'Invalid password';

                          return null;
                        },
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {},
                      child: Text(
                        'Forgot Paswword',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.height * 0.05),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  onPressed: this._submit,
                  child: Text(
                    'Sing in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(height: responsive.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to friendly Desi?',
                    style: TextStyle(
                      fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Sing up',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                  ),
                ],
              ),
              SizedBox(height: responsive.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
