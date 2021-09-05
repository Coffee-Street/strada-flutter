import 'package:flutter/material.dart';

import 'package:src/resource/Screens/Splash.dart';
import 'package:src/resource/design/ViewSetting.dart';

void main(){
  runApp(new MaterialApp(
    home: new StartScreen(),
  ));
}

class StartScreen extends StatelessWidget {
  static ViewSetting viewSetting = ViewSetting();
  @override
  Widget build(BuildContext context) {
    viewSetting.SetViewSize(context);
    return Scaffold(
      body: SplashPage(),
    );
  }
}