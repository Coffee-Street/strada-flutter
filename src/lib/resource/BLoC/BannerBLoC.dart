import 'package:dio/dio.dart';

import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Retrofit/RestClient.dart';

class BannerBloc {
  static Dio _dio = Dio();
  static RestClient _restClient = RestClient(_dio);
  static AuthBloc authBloc = AuthBloc();

  BannerBloc() {
  }

  /// Banner List
  /// ----------------------------------------
  /// String  | String  | String    | String
  /// ----------------------------------------
  /// code    | title   | imageUrl  | message
  /// ----------------------------------------
  Future<List> getBannerInfo() async {
    String _token = authBloc.getAccessToken();
    print(_token);
    var res = await _restClient.getBanners(_token).then((banners){
      return banners;
    }).catchError((error) {
      print('getBannerInfo error : $error');
      return [['', '', '', '']];
    });
    return [['', '', '', '']];
  }
}