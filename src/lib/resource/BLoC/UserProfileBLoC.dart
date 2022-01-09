import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class UserProfileBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);
  static AuthBloc authBloc = AuthBloc();

  UserProfileBloc() {
  }

  /// User Profile
  /// ----------------------------------------
  /// var     | String  | var
  /// ----------------------------------------
  /// id      | userId  | point
  /// ----------------------------------------
  Future<UserProfile> getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPhoneNumber = prefs.getString('phoneNumber');

    String _token = authBloc.getAccessToken();
    var res = await _restClient.getUserProfile('Bearer ' + _token, 1).then((profile){ // TODO : 상수 1이 아닌 userPhoneNumber 삽입
      print('----- Responsed the User Profile -----');
        print(profile);
      print('--------------------');
      return Future.value(profile);
    }).catchError((error) {
      print('getUserProfile error : $error');
      return [];
    });
    return res;
  }
}