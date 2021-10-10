import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class AuthBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);

  static String _token = '';

  AuthBloc()
  {
  }

  Future<bool> getHealth() async {
    if(_token == '')
      return Future.value(false);

    var resHealth = await _restClient.getPong(_token).then((response) {
      return Future.value(true);
    }).catchError((error) {
      print('Get health error: $error');
      return Future.value(false);
    });
    return resHealth;
  }

  Future<bool> getToken(String phoneNumber) async {
    if(_token == '') {
      var resToken = await _restClient.getToken(phoneNumber).then((resToken){
        _token = resToken.accessToken;
        print(_token);
        return Future.value(true);
      }).catchError((error) {
        print('Get token error: $error');
        return Future.value(false);
      });
      return resToken;
    }
    else {
      var resHealth = getHealth().then((isHealth){
        print('server heath : $isHealth');
        return Future.value(isHealth);
      }).catchError((error) {
        print('error: $error');
        return Future.value(false);
      });
      return resHealth;
    }
  }

  Future<bool> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPhoneNumber = prefs.getString('phoneNumber');

    if(userPhoneNumber == null) {
      print('No automatic login ID.'); // 저장 된 자동 로그인 ID 없음
      return Future.value(false);
    }

    var res = await logIn(userPhoneNumber, true).then((response) {
      print('Auto Login succeeded : $response');
      return Future.value(response);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });

    return res;
  }

  Future<bool> logIn(String phoneNumber, bool isAutoLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await getToken(phoneNumber).then((response) {
      if(_token != '') {
        if(isAutoLogin == true) {
          prefs.setString('phoneNumber', phoneNumber);
        }
        else {
          prefs.setString('phoneNumber', null);
        }
        print('Login succeeded : $response');
        return Future.value(response);
      }
      else
        return Future.value(false);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });

    return res;
  }

  Future<bool> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', null);
    _token = '';

    print('Logout succeeded : true');
    return Future.value(true);
  }

  String getAccessToken() {
    return _token;
  }
}