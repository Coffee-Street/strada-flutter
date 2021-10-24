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
  Future<List<BannerInfo>> getBannerInfo() async {
    String _token = authBloc.getAccessToken();
    var res = await _restClient.getBanners('Bearer ' + _token).then((banners){
      print('----- Responsed the Banner Info -----');
      for(var i=0 ; i < banners.length ; i++) {
        print(banners[i]);
      }
      print('--------------------');
      return Future.value(banners);
    }).catchError((error) {
      print('getBannerInfo error : $error');
      return [];
    });
    return res;
  }
}