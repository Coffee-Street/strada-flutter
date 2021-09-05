import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:src/resource/design/ColorPalette.dart';
import 'package:src/resource/BLoC/AuthBLoC.dart';
import 'package:src/resource/Screens/Auth.dart';

class HomePage extends StatelessWidget {
  // TODO : Home Widget 작성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageDisplay(),
    );
  }
}

class HomePageDisplay extends StatelessWidget {
  // Session List
  Widget appbarSession(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        color: MainColorPalette.monoWhite,
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
      padding: EdgeInsets.zero,
      color: MainColorPalette.monoWhite,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 44, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '어서오세요\n사용자 휴대폰 번호', // TODO : user id(phone number) 적용
              style: TextStyle(
                fontSize: 15,
                color: MainColorPalette.monoDarkGray,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '0,000P', // TODO : user point 적용
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

  Widget eventSession(BuildContext context){
    return Container(
      height: 350,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MainColorPalette.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Event Session',
            ),
            Text(
              'Ficture',
            ),
          ],
        ),
      ),
    );
  }

  Widget orderSession(BuildContext context){
    return Container(
      padding: EdgeInsets.only(
        top: 77,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: Row(
          children: <Widget>[
            Text(
              '주문하기',
            ),
          ],
        ),
      ),
    );
  }
  // TODO : Session 추가

  static AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    double maxScreenWidth = MediaQuery.of(context).size.width;
    double iconSize;
    if(maxScreenWidth > 1){
      iconSize = 100;
    }
    else {
      iconSize = 48;
    }

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
              // width: 48, height: 48,
              width: iconSize, height: iconSize,
              color: MainColorPalette.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 48,
            icon: Image.asset(
              'assets/icon_images/icon_notice@2x.png',
              // width: 48, height: 48,
              // width: iconSize, height: iconSize,
              color: MainColorPalette.primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body:Padding(
        padding: EdgeInsets.only(
          left: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // appbarSession(context),
            authSession(context),
            eventSession(context),
            orderSession(context),
          ],
        ),
      ),
    );
  }
}