import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/functional/user_secure_storage.dart';
import 'package:tim/models/getRequest.dart';

import 'requestForAdmin.dart';
import 'request_details.dart';

class RequestCreate extends StatefulWidget {

  @override
  _RequestCreateState createState() => _RequestCreateState();
}

class _RequestCreateState extends State<RequestCreate> {
String rol;
  Future init() async{
    final role = await UserSecureStorage().getUserrole();

    setState(() {
      rol = role;
    });


  }


  @override
  void initState() {

    super.initState();
    init();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetRequest>(
      stream: PageManager.getRequest(),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange, valueColor:AlwaysStoppedAnimation<Color>(Colors.white),));
        }
        return Scaffold(
          body: Container(
            child: ListView.builder(
              itemCount: snapshot.data.count,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: () {
                    print(rol);
                    if(rol == "client"){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RequestDetails(id: index)));}
                    else{
                      print("${snapshot.data.results[index].id}  indexxxx");
                      PageManager.setUnseenRequest(snapshot.data.results[index].id);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RequestForAdmin(id: index)));}
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat.yMd().format(snapshot.data.results[index].createdAt),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          //color: Colors.amber,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        //color: Colors.red,
                                        child: Center(child:  Text( snapshot.data.results[index].status == "pending" ? 'Սպասման մեջ' : snapshot.data.results[index].status == "cancel" ? 'Չեղարկված' : snapshot.data.results[index].status == "under_review" ?  'Քննարկման մեջ' : snapshot.data.results[index].status == "done" ? 'Ավարտված':"")),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: snapshot.data.results[index].status == "pending" ? Colors.orange : snapshot.data.results[index].status == "cancel" ? Colors.red : snapshot.data.results[index].status == "under_review" ?  Colors.green : snapshot.data.results[index].status == "done" ? Colors.green : Colors.transparent,
                                        ),
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.orange,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data.results[index].title,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    snapshot.data.results[index].text,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.black,
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
                );
              },
            ),
          ),
        );
      }
    );
  }
}
