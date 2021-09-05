import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewSetting {
  ViewSetting._();
  ViewSetting()
  {
    // Do Something
  }

  Future<void> SetViewSize(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    prefs.setString('ViewWidth', width.toString());
    prefs.setString('ViewHeight', height.toString());
  }

  Future<double> GetViewWidth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stringWidth = prefs.getString('ViewWidth');
    var width = double.tryParse(stringWidth);

    return width;
  }

  Future<double> GetViewHeight() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stringHeight = prefs.getString('ViewHeight');
    var height = double.tryParse(stringHeight);

    return height;
  }

  Future<List> GetViewSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringWidth = prefs.getString('ViewWidth');
    var width = double.tryParse(stringWidth);
    String stringHeight = prefs.getString('ViewHeight');
    var height = double.tryParse(stringHeight);

    return [width, height];
  }
}