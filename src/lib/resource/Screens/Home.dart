import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:src/resource/Retrofit/RestClient.dart';
import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/BLoC/BannerBLoC.dart';
import 'package:src/resource/BLoC/UserProfileBLoC.dart';

import 'package:src/resource/design/ColorPalette.dart';

import 'package:src/resource/Screens/Auth.dart';
import 'package:src/resource/Screens/Menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageDisplay(),
    );
  }
}

class HomePageDisplay extends StatefulWidget {
  @override
  _HomePageDisplayState createState() => _HomePageDisplayState();
}

class _HomePageDisplayState extends State<HomePageDisplay> {
  static AuthBloc authBloc = AuthBloc();
  static BannerBloc bannerBloc = BannerBloc();
  static UserProfileBloc userProfBloc = UserProfileBloc();

  List<BannerInfo> _banners = [];
  UserProfile _profile = new UserProfile(userId: '0', point: 0);

  // Session List
  Widget appbarSession(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: 88,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Text(
                    '홈',
                    style: TextStyle(
                      color: MainColorPalette.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      iconSize: 48,
                      icon: Image.asset(
                        'assets/icon_images/icon_voc@2x.png',
                        // width: iconSize, height: iconSize,
                        color: MainColorPalette.primaryColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 48,
                      icon: Image.asset(
                        'assets/icon_images/icon_notice@2x.png',
                        // width: iconSize, height: iconSize,
                        color: MainColorPalette.primaryColor,
                      ),
                      onPressed: () {
                        print("눌러짐");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget authSession(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 0, 0, 0),
      color: MainColorPalette.monoWhite,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 44, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '어서오세요\n' + _profile.userId,
              style: TextStyle(
                fontSize: 15,
                color: MainColorPalette.monoDarkGray,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  _profile.point.toString() + ' P',
                  style: TextStyle(
                    fontSize: 36,
                    color: MainColorPalette.primaryColor,
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icon_images/icon_more_thick_blue.png',
                    width: 36, height: 36,
                    color: MainColorPalette.primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            RaisedButton(
              child: Text(
                'LogOut',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () async {
                var resLoggedOut = authBloc.logOut();
                resLoggedOut.then((isSuccess) {
                  if(isSuccess != null && isSuccess == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthMainPage()),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bannerSession(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      height: 344.0,
      child: Swiper(
        loop: true,
        pagination: new SwiperPagination(
          margin: EdgeInsets.only(left: 24.0),
          alignment: Alignment.bottomLeft,
          builder: new DotSwiperPaginationBuilder(
            size: 5.0,
            activeSize: 5.0,
            space: 5.0,
            color: MainColorPalette.monoGray,
            activeColor: MainColorPalette.primaryColor,
          ),
        ),
        itemCount: _banners.length,
        viewportFraction: 1.0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(left: 24.0, bottom: 35.0),
            width: MediaQuery.of(context).size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: MainColorPalette.primaryColor,
                color: Color(0xff000000 + int.parse(_banners[index].backColor.substring(1, _banners[index].backColor.length), radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                image: DecorationImage(
                  image: NetworkImage(_banners[index].imageUrl),
                  // fit: BoxFit.fill,
                  fit: BoxFit.contain,
                  // fit: BoxFit.cover,
                  // fit: BoxFit.fitWidth,
                  // fit: BoxFit.fitHeight,
                  // fit: BoxFit.none,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 35.0),
                    child: Text(
                      _banners[index].title,
                      style: TextStyle(
                        color: MainColorPalette.monoWhite,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 172.0),
                    child: Text(
                      _banners[index].contents,
                      style: TextStyle(
                        color: MainColorPalette.monoWhite,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget orderSession(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 77.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              '주문하기',
              style: TextStyle(
                color: MainColorPalette.primaryColor,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              iconSize: 48,
              icon: Image.asset(
                'assets/icon_images/icon_more_thick_blue.png',
                color: MainColorPalette.primaryColor,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => MenuPopUpPage(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: MainColorPalette.monoWhite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void getBannerInfo() async {
    var resBanner = bannerBloc.getBannerInfo();
    resBanner.then((banners) {
      setState(() {
        _banners = banners.cast<BannerInfo>();
      });
    });
  }

  void getUserProfile() async {
    var resProfile = userProfBloc.getUserProfile();
    resProfile.then((profile) {
      setState(() {
        _profile = profile;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getUserProfile();
      getBannerInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MainColorPalette.monoWhite,
        elevation: 0,
        toolbarHeight: 88,
        title: Text(
          '홈',
          style: TextStyle(
            color: MainColorPalette.primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 48,
            icon: Image.asset(
              'assets/icon_images/icon_voc@2x.png',
              width: iconSize, height: iconSize,
              color: MainColorPalette.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 48,
            icon: Image.asset(
              'assets/icon_images/icon_notice@2x.png',
              width: iconSize, height: iconSize,
              color: MainColorPalette.primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: MainColorPalette.monoWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // appbarSession(context),
            authSession(context),
            bannerSession(context),
            orderSession(context),
          ],
        ),
      ),
    );
  }
}