import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/screens/add_request.dart';

import 'create_request.dart';
import 'main_drower.dart';

class Request extends StatefulWidget {
  final int id;

  const Request({Key key, this.id}) : super(key: key);
  @override
  _RequestState createState() => _RequestState(id);
}

class _RequestState extends State<Request> with SingleTickerProviderStateMixin {
  final int id;
  bool visible;

  _RequestState(this.id);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return StreamBuilder<GetMe>(
        stream: PageManager.getMe(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            snapshot.data.role == "staff" ? visible = false : visible = true;
          }
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          }
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Հարցումներ'),
              backgroundColor: Colors.orange,
            ),
            body: RequestCreate(),
            floatingActionButton: Visibility(
              visible: (snapshot.data.status == 1),
              child: Visibility(
                visible: visible,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRequest()));
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.orange),
              ),
            ),
            drawer: Drawer(
              child: MainDrawer(),
            ),
          );
        });
  }
}
