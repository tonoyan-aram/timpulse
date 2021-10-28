import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim/feed_component.dart';

//import 'package:tim/feed_component.dart';

import 'main_drower.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Գլխավոր էջ'),
        backgroundColor: Colors.orange,
      ),
      body: FeedComponent(),
      drawer: Drawer(
        child: MainDrawer(),
      ),
    );
  }
}
