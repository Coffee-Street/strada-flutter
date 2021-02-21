import 'package:flutter/material.dart';

// TODO : 연결할 파일 import
import 'Home.dart';
import 'Auth.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        primaryColor: Colors.indigo,
        // visual density
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(title: 'Coffee Street'),
    );
  }
}


class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<MainMenu> {
  int _curMenuIndex = 2;
  final List<Widget> _childMenuList = [
    // TODO : Add new Widgets (functional screen)
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.deepPurple),
    HomePage(),
    PlaceholderWidget(Colors.greenAccent),
    PlaceholderWidget(Colors.black),
  ];

  void _OnTabTapped(int index) {
    setState(() {
      _curMenuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () { }, // TODO : Do write a redirect event
              tooltip: 'Notifications',
            )
          ]
      ),
      body: _childMenuList[_curMenuIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _OnTabTapped,
        currentIndex: _curMenuIndex,

        // Set Items
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('Menu'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Event'),
          ),
        ],

        // Set Theme
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO : Do write a redirect event
        tooltip: 'My Cart',
        child: Icon(Icons.add_shopping_cart),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}