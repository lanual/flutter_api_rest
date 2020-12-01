import 'package:flutter/material.dart';
import 'package:flutter_api_ret/api/authetication_api.dart';
import 'package:flutter_api_ret/data/authentication_client.dart';
import 'package:flutter_api_ret/models/user.dart';
import 'package:flutter_api_ret/page/login_page.dart';
import 'package:flutter_api_ret/utils/logs.dart';
import 'package:flutter_api_ret/utils/progress_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  static const homePage = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    _loadUserData();
  }

  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _auth = GetIt.instance<AuthenticationApi>();
  User _user;
  String token;

  Future<void> _loadUserData() async {
    token = await _authenticationClient.accesToken(context);
    final response = await _auth.getUserInfo(token);

    if (response.statusCode == 200) {
      _user = response.data;
      setState(() {});
    }
  }

  Future<void> _sigOut() async {
    await _authenticationClient.singOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.loginPage, (_) => false);
  }

  Future<void> _pickImage() async {
    ProgressDialog.show(context);

    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final filaName = path.basename(pickedImage.path);

      final response = await _auth.updaTeAvatar(token, filaName, bytes);

      if (response.statusCode == 200) {
        final imageUrl =
            'https://curso-api-flutter.herokuapp.com${response.data}';
        _user = _user.copyWith(avatar: response.data);
        setState(() {});
        Logs.p.i('IMAGE URL: $imageUrl');
      }
    }
    ProgressDialog.dismiss(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  if (_user.avatar != null)
                    ClipOval(
                      child: Image.network(
                        "https://curso-api-flutter.herokuapp.com${_user.avatar}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Text(_user.id),
                  Text(_user.email),
                  Text(_user.username),
                  Text(_user.createdAt.toIso8601String()),
                ],
              ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: this._pickImage,
              child: Text('Update Avatar'),
            ),
            FlatButton(
              onPressed: this._sigOut,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
