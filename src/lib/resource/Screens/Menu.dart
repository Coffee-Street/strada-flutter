import 'package:flutter/material.dart';

import 'package:src/resource/Retrofit/RestClient.dart';
import 'package:src/resource/BLoC/CoffeeBLoC.dart';

import 'package:src/resource/design/ColorPalette.dart';

class MenuCardPage extends StatefulWidget {
  String _name;
  var _price;


  MenuCardPage(String name, var price){
    this._name = name;
    this._price = price;

    print(_name.toString() + ", " + _price.toString());
  }

  @override
  _MenuCardPageState createState() => _MenuCardPageState(_name, _price);
}

class _MenuCardPageState extends State<MenuCardPage> {
  String _name;
  var _price;

  _MenuCardPageState(String name, var price){
    this._name = name;
    this._price = price;
  }

  @override
  void initState() {
    super.initState();
  }
  
  int _num = 0;

  // TODO : 재고 현황에 따른 sold out 처리
  void _decreaseMenu() {
    setState(() {
      if (_num < 1)
        return;
      _num--;
    });
  }
  void _increaseMenu() {
    setState(() {
      _num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _name.toString(),
                  style: TextStyle(
                    color: MainColorPalette.monoBlack,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '옵션 / 사이즈',
                  style: TextStyle(
                    color: MainColorPalette.monoBlack,
                    fontSize: 17,
                  ),
                ),
                Text(
                  _price.toString() + ' 원',
                  style: TextStyle(
                    color: MainColorPalette.monoBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: MainColorPalette.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  iconSize: 36,
                  icon: Image.asset(
                    'assets/icon_images/icon_minus.png',
                    color: MainColorPalette.monoWhite,
                  ),
                  onPressed: () {
                    _decreaseMenu();
                  },
                ),
                Text(
                  "$_num",
                  style: TextStyle(
                    color: MainColorPalette.monoWhite,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  iconSize: 36,
                  icon: Image.asset(
                    'assets/icon_images/icon_plus.png',
                    color: MainColorPalette.monoWhite,
                  ),
                  onPressed: () {
                    _increaseMenu();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuPopUpPage extends StatefulWidget {
  @override
  _MenuPopUpPageState createState() => _MenuPopUpPageState();
}

class _MenuPopUpPageState extends State<MenuPopUpPage> {
  static CoffeeBloc coffeeBloc = CoffeeBloc();

  List<Coffee> _coffees = [];

  void getAllCoffee() async {
    var resAllCoffee = coffeeBloc.getAllCoffee();
    resAllCoffee.then((coffees) {
      setState(() {
        _coffees = coffees.cast<Coffee>();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAllCoffee();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "즐겨찾는 메뉴",
                style: TextStyle(
                  color: MainColorPalette.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                iconSize: 48,
                icon: Image.asset(
                  'assets/icon_images/icon_cancel.png',
                  color: MainColorPalette.primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          // TODO : 선 넣기
          Container(
            padding: EdgeInsets.only(top: 15.0),
            height: 600, // TODO : 왜 계속 안되지?
            child: ListView.builder(
              itemCount: _coffees.length,
              itemBuilder: (context, index){
                return MenuCardPage(_coffees[index].name, _coffees[index].price);
              },
            ),
          ),
        ],
      ),
    );
  }
}