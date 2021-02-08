import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class ExBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);

  static String _token;

  ExBloc()
  {
    _token = '';
  }

  Future<bool> getHealth() async {
    if(_token == '')
      return Future.value(false);

    var resHealth = await _restClient.getPong(_token).then((response) {
      return Future.value(true);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });
    return resHealth;
  }

  Future<bool> getToken(String phoneNumber) async {
    if(_token == '') {
      var resToken = await _restClient.getToken(phoneNumber).then((resToken){
        _token = resToken.accessToken;
        return Future.value(true);
      }).catchError((error) {
        print('error: $error');
        return Future.value(false);
      });
      return resToken;
    }
    else {
      var resHealth = getHealth().then((isHealth){
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

    if(userPhoneNumber == null) // 저장 된 자동 로그인 ID 없음
      return Future.value(false);

    var res = await logIn(userPhoneNumber).then((response) {
      return Future.value(response);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });

    return res;
  }

  Future<bool> logIn(String phoneNumber) async {
    var res = await getToken(phoneNumber).then((response) {
      if(_token != '')
        return Future.value(true);
      else
        return Future.value(false);
    }).catchError((error) {
      print('error: $error');
      return Future.value(false);
    });

    return res;
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', null);
    _token = '';
  }
}