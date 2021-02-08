import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:src/Home.dart';
import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Retrofit/Model/BaseModel.dart';
import 'package:src/resource/Retrofit/Model/ServerError.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

import 'Main.dart';

TextEditingController phoneNumberController = TextEditingController();
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
  ExBloc _exBloc = ExBloc();
  // RestClient restClient;
  bool _autoLogin = true;

  Future<bool> getToken({
    @required String phoneNumber,
  }) async {
    await _exBloc.logIn(phoneNumber).then((isLoggedin) {
      print(isLoggedin);
      return Future.value(isLoggedin);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });
  }

  @override
  void initState() {
    // Dio dio = Dio();
    // restClient = RestClient(dio);
    var loggedIn = _exBloc.autoLogIn();
    loggedIn.then((val) {
      print(val);
      return loggedIn;
    }).catchError((error) {
      print('error: $error');
    });
  }

  // Widget _getAuthScreen(BuildContext context) {
  //   if(!isSigned)
  //     return Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             '아직 로그인 되지 않았습니다.',
  //             style: TextStyle(
  //               fontSize: 20,
  //               color: Colors.grey,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           RaisedButton(
  //             color: Theme.of(context).primaryColor,
  //             textColor: Colors.white,
  //             child: Text('Sign up'),
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => SignUpPage()),
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   else
  //     return AuthUserPage();
  // }

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
                  var resLoggedin = _exBloc.logIn(phoneNumberController.text);
                  resLoggedin.then((res) {
                    print(res);
                    if(res != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  }).catchError((error) {
                    print('error: $error');
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

// final signUpController = TextEditingController();
//
// class AuthUserPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Welcome'),
//     );
//   }
// }
//
// class SignUpPage extends StatelessWidget {
//   getUserToken({
//     @required String phoneNumber,
//   }){
//     Future.microtask(() async {
//       Token userToken;
//       try {
//         // userToken = await restClient.getToken(phoneNumber);
//       } catch (error, stacktrace) {
//         print("Exception occured: $error stackTrace: $stacktrace");
//         return BaseModel()..setException(ServerError.withError(error: error));
//       }
//       return BaseModel()..data = userToken.accessToken;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: signUpController,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: '휴대폰 번호',
//               ),
//             ),
//             Text(
//               'Sign-up을 누르시면 개인정보 수집에 동의하는 것으로 간주합니다.',
//               style: TextStyle(
//               fontSize: 10,
//               color: Colors.grey,
//               fontWeight: FontWeight.w400,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.all(3.0),
//                   child: RaisedButton(
//                     child: Text('Cancel'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(3.0),
//                   child: RaisedButton(
//                     color: Theme.of(context).primaryColor,
//                     textColor: Colors.white,
//                     child: Text('Sign-up'),
//                     onPressed: () {
//                       final TokenBase = getUserToken(phoneNumber: signUpController.text);
//                       if(TokenBase.Data != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomePage()),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//     );
//   }
// }