import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class CoffeeBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);
  static AuthBloc authBloc = AuthBloc();

  CoffeeBloc() {
  }

  /// Coffee
  /// ----------------------------------------
  /// String  / String  / String      / String
  /// ----------------------------------------
  /// id      / name    / description / category
  /// ----------------------------------------
  Future<List<Coffee>> getAllCoffee() async {
    String _token = authBloc.getAccessToken();
    var res = await _restClient.getAllCoffee('Bearer ' + _token).then((coffees){
      print('----- Responsed the Coffee -----');
      print(coffees);
      print('--------------------');
      return Future.value(coffees);
    }).catchError((error) {
      print('getCoffee error : $error');
      return [];
    });
    return res;
  }
}