import 'package:flutter/material.dart';

final bool isSigned = false;

class UserInfo {
  UserInfo(this.name);

  String id; // id : 휴대폰 번호
  String name;
  // TODO : 무엇인가 더 추가
}

class AuthMainPage extends StatefulWidget {
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  Widget _getAuthScreen(BuildContext context) {
    if(!isSigned)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '아직 로그인 되지 않았습니다.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Sign up'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
          ],
        ),
      );
    else
      return AuthUserPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _getAuthScreen(context),
    );
  }
}

final signUpController = TextEditingController();

class AuthUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome'),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: signUpController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '휴대폰 번호',
              ),
            ),
            Text(
              'Sign-up을 누르시면 개인정보 수집에 동의하는 것으로 간주합니다.',
              style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Sign-up'),
                    onPressed: () {
                      // TODO : 로그인 시도
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}