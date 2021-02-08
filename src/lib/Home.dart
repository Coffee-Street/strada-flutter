import 'package:flutter/material.dart';

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
  Widget authSession = Container(
    height: 200,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    // child: AuthMainPage(),
  );
  // TODO : Session 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            authSession,
            Icon(Icons.more_horiz,), // TODO : 나누는 가로선을 넣고 싶었다.
          ],
        ),
      ),
    );
  }
}