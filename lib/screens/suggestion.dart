import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getForum.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/models/getRequest.dart';
import 'package:tim/screens/add_request.dart';
import 'package:tim/screens/home.dart';
import 'package:tim/screens/suggestion_item_details.dart';
import 'package:tim/screens/suggestion_item_details_client.dart';

import 'addForum.dart';
import 'create_request.dart';
import 'main_drower.dart';

class Suggestion extends StatefulWidget {
  final int id;

  const Suggestion({Key key, this.id}) : super(key: key);
  @override
  _Suggestion createState() => _Suggestion(id);
}

class _Suggestion extends State<Suggestion> {
  final int id;
  bool visible = true;
  _Suggestion(this.id);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return StreamBuilder<GetMe>(
        stream: PageManager.getMe(),
        builder: (context, snapshot) {

          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          }
          if (snapshot.data != null) {
            snapshot.data.role == "staff" ? visible = true : visible = false;
          //print("${snapshot.data.role} ----------- snapshot.data.role-------");
          }
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Առաջարկներ'),
              backgroundColor: Colors.orange,
            ),
            body: StreamBuilder<Forum>(
                stream: PageManager.getForum(),
                builder: (context, snapshot) {
                  //print("${snapshot.data} snapshot.dataaa");
                  if (snapshot.data == null) {

                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ));
                  }
                 // print("${snapshot.data.results.length} -----snapshot.data.results--------");
                  return ListView.builder(

                    itemCount: snapshot.data.results?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            //print("${snapshot.data.results[index].id}  idulikkk");
                            visible ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SuggestionDetails(id: snapshot.data.results[index].id??""))) : Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) =>
                                      SuggestionDetailsClient(id: snapshot.data.results[index].id??"")));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.grey[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Image.network(
                                  //   'https://picsum.photos/seed/789/300',
                                  //   width: double.infinity,
                                  //   height: 180,
                                  //   fit: BoxFit.cover,
                                  // ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                                  Text(
                                                    DateFormat.yMd()
                                                        .format(snapshot
                                                            .data
                                                            .results[index]
                                                            .createdAt??""),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      //color: Colors.amber,
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible: !visible,
                                                      child: Visibility(
                                                          visible: snapshot.data.results[index].answeredByMe,
                                                          child: Text("Պատասխանած",style: TextStyle(color: Colors.red),))),
                                                  //IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){})
                                                ],

                                          ),
                                        ),
                                        Divider(
                                          color: Colors.orange,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 3, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data.results[index]?.author??"",
                                                style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // Text(
                                              //   DateFormat.yMMMMEEEEd().format(DateTime.now()),
                                              //   style: TextStyle(
                                              //     fontFamily: 'Poppins',
                                              //     color: Colors.amber,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 8, 0, 0),
                                          child: Text(
                                            snapshot.data.results[index].text??"",
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.black87,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
            floatingActionButton: Visibility(
              visible: visible,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddForum()));
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.orange),
            ),
            drawer: Drawer(
              child: MainDrawer(),
            ),
          );
        });
  }


}
