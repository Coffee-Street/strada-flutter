import 'package:flutter/material.dart';

import 'package:src/Home.dart';
import 'package:src/resource/BLoC/AuthBLoC.dart';

TextEditingController phoneNumberController = TextEditingController();

class AuthMainPage extends StatefulWidget {
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  AuthBloc _authBloc = AuthBloc();
  bool _autoLogin = true;

  Future<bool> login({ // ignore: missing_return
    @required String phoneNumber,
  }) async {
    await _authBloc.logIn(phoneNumber, _autoLogin).then((isSuccess) {
      print('Login result : $isSuccess');
      return Future.value(isSuccess);
    }).catchError((error) {
      print('Login error: $error');
      return Future.value(false);
    });
  }

  Future<bool> autoLogin({ // ignore: missing_return
    @required String phoneNumber,
  }) async {
    await _authBloc.autoLogIn().then((isSuccess) {
      print('Auto login result : $isSuccess');
      return Future.value(isSuccess);
    }).catchError((error) {
      print('Auto login error: $error');
      return Future.value(false);
    });
  }

  @override
  void initState() {
    super.initState();

    var autoLoggedIn = autoLogin();
    autoLoggedIn.then((isSuccess) {
      if(isSuccess == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(),
              child: Image.asset(
                'assets/splash_logo.png',
                width: 120,
                height: 81,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 63, 0, 25),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: '전화번호를 입력해주세요.',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 72,
              child:  RaisedButton(
                child: Text(
                  '시작하기',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () async {
                  var resLoggedIn = login(phoneNumber :phoneNumberController.text);
                  resLoggedIn.then((resSuccess) {
                    if(resSuccess != null && resSuccess == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '자동 로그인',
                  ),
                  Checkbox(
                    value: _autoLogin,
                    onChanged: (bool value) {
                      setState(() {
                        _autoLogin = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}