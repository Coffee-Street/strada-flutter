import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'RestClient.g.dart';

// @RestApi(baseUrl:'http://ec2-3-35-55-47.ap-northeast-2.compute.amazonaws.com:8080')
@RestApi(baseUrl:'http://192.168.35.79:8080') // TODO : Loaclhost for test
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}){
    dio.options = BaseOptions(receiveTimeout: 10000, connectTimeout: 10000);
    return _RestClient(dio, baseUrl: baseUrl);
  }

  // Health
  @GET('/strada/v1/health')
  Future<void> getHealth();

  // Token
  @POST('/strada/v1/account')
  Future<Token> getToken(
      @Field("phoneNumber") String phoneNumber
      );

  // Ping-Pong
  @GET('/ping')
  Future<String> getPong(
      @Header("authorization") String token,
      );

  // Banner
  @GET('/strada/v1/banners')
  Future<List<BannerInfo>> getBanners(
      @Header("authorization") String token,
      );

  // User Profile
  @GET('/strada/v1/profiles')
  Future<UserProfile> getUserProfile(
      @Header("authorization") String token,
      );
}

@JsonSerializable()
class Token {
  String accessToken;

  Token({
    this.accessToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class BannerInfo {
  String codeName;
  String title;
  String imageUrl;
  String contents;
  String backColor;
  String fontColor;

  BannerInfo({
    this.codeName,
    this.title,
    this.imageUrl,
    this.contents,
    this.backColor,
    this.fontColor,
  });

  @override
  String toString()
  {
    return "code: $codeName, title: $title, imageUrl: $imageUrl, message: $contents, back: $backColor, font: $fontColor";
  }

  factory BannerInfo.fromJson(Map<String, dynamic> json) {
    return BannerInfo(
      codeName: json["code"],
      title: json["title"],
      imageUrl: json["imageUrl"],
      contents: json["message"],
      backColor: json["backgroundColor"],
      fontColor: json["fontColor"],
    );
  }
  Map<String, dynamic> toJson() => _$BannerInfoToJson(this);
}

@JsonSerializable()
class UserProfile {
  var id;
  String userId;
  var point;

  UserProfile({
    this.id,
    this.userId,
    this.point,
  });

  @override
  String toString()
  {
    return "id: $id, userId: $userId, point: $point";
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      userId: json["userId"],
      point: json["point"],
    );
  }
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
