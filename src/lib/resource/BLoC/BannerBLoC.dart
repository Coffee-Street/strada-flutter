import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class BannerBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);
  static AuthBloc authBloc = AuthBloc();

  String _token;
  BannerBloc() {
    _token = authBloc.getAccessToken();
  }

  /// Banner List
  /// ----------------------------------------
  /// String  | String  | String    | String
  /// ----------------------------------------
  /// code    | title   | imageUrl  | message
  /// ----------------------------------------
  Future<List> getBannerInfo() async {
    var res = await _restClient.getBanners(_token).then((banners){
      return [banners.codeName, banners.title, banners.imageUrl, banners.contents];
    }).catchError((error) {
      print('error: $error');
      return ['', '', '', ''];
    });
    return ['', '', '', ''];
  }
}