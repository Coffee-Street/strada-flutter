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

  // Coffee
  @GET('/strada/v1/coffees/admin')
  Future<List<Coffee>> getAllCoffee(
      @Header("authorization") String token,
      );
}

// AuthBLoC
@JsonSerializable()
class Token {
  String accessToken;

  Token({
    this.accessToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

// BannerBLoC
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

// UserProfileBLoC
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

// BeanBLoC
@JsonSerializable()
class Bean {
  String id;
  String origin;
  String farm;
  String description;
  String processing;
  String roasting;
  String kind;
  String grade;

  Bean({
    this.id,
    this.origin,
    this.farm,
    this.description,
    this.processing,
    this.roasting,
    this.kind,
    this.grade,
  });

  @override
  String toString()
  {
    return "id: $id, origin: $origin, farm: $farm, description: $description,"
        "processing: $processing, roasting: $roasting, kind: $kind, grade: $grade";
  }

  factory Bean.fromJson(Map<String, dynamic> json) {
    return Bean(
      id: json["id"],
      origin: json["origin"],
      farm: json["farm"],
      description: json["description"],
      processing: json["processing"],
      roasting: json["roasting"],
      kind: json["kind"],
      grade: json["grade"],
    );
  }
  Map<String, dynamic> toJson() => _$BeanToJson(this);
}

// CoffeeBLoC
@JsonSerializable()
class Coffee {
  var id;
  String name;
  String imageUrl;
  var price;
  String description;
  String category;
  Bean bean;

  Coffee({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.description,
    this.category,
    this.bean,
  });

  @override
  String toString()
  {
    return "id: $id, name: $name, imgUrl: $imageUrl, price: $price, description: $description, category: $category, bean: $bean";
  }

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      price: json["price"],
      description: json["description"],
      category: json["category"],
      bean: json["bean"],
    );
  }
  Map<String, dynamic> toJson() => _$CoffeeToJson(this);
}