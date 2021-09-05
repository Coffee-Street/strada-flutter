import 'dart:async';

import 'package:flutter/material.dart';

import '../design/ColorPalette.dart';
import '../design/ViewSetting.dart';
import 'Auth.dart';
import 'Main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static ViewSetting viewSetting = ViewSetting();
  double screenW = 0, screenH = 0;

  @override
  void initState() {
    super.initState();
    var res = viewSetting.GetViewSize().then((screenSize) {
      screenW = screenSize[0];
      screenH = screenSize[1];
      print('width : $screenW');
      print('height : $screenH');

      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) => AuthMainPage()
              )
          )
      );
    }).catchError((error) {
      print('error: $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MainColorPalette.monoWhite,
        child:Center(
          child: Image.asset(
            'assets/splash_logo.png',
            width: 120,
            height: 81,
          ),
        ),
    );
  }
}
class AfterSplash extends StatefulWidget {
  @override
  _AterSplashState createState() => _AterSplashState();
}
class _AterSplashState extends State<AfterSplash> {
  bool _autoLogin = true;


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
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MainColorPalette.primaryColor),
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
                onPressed: () => MainApp(),
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