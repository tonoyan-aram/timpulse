import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim/functional/functions.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/functional/user_secure_storage.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/models/getUnseenRequest.dart';

import 'package:tim/screens/home.dart';
import 'package:tim/screens/log_in.dart';
import 'package:tim/screens/profile.dart';
import 'package:tim/screens/request.dart';

import '../about.dart';
import 'suggestion.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool uploading = false;
  List<File> _image = [];
  //final picker = ImagePicker();

  Future<PickedFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetMe>(
        stream: PageManager.getMe(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          } else
            return Column(children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(snapshot.data.image !=
                                    null
                                ? "${FunctionalPage.urlapi}${snapshot.data.image}"
                                : "https://www.kenyons.com/wp-content/uploads/2017/04/default-image.jpg"),
                          ),
                          // pickPicker(fileName, (file) {
                          //   this.setState(() {
                          //     fileName = file.path.toString();
                          //
                          //     PageManager.editMyProfile(
                          //         snapshot.data.firstName,
                          //         snapshot.data.lastName,
                          //         snapshot.data.email,
                          //         fileName,
                          //         snapshot.data.userSegments);
                          //     this.setState(() {
                          //
                          //     });
                          //
                          //   });
                          // })
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        snapshot.data.firstName + " " + snapshot.data.lastName,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        snapshot.data.email,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        height: 2,
                        //indent: 5,
                        thickness: 2,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Now let's Add the button for the Menu
              //and let's copy that and modify it
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                leading: Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                title: Text(
                  "Գլխավոր էջ",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Request(id: snapshot.data.id)));
                },
                leading: Icon(
                  Icons.inbox,
                  color: Colors.orange,
                ),
                title: Text(
                  "Հարցումներ",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Visibility(
                  visible: (snapshot.data.role == "staff"),
                  child: StreamBuilder<GetUnseenRequest>(
                      stream: PageManager.getUnseenRequest(),
                      builder: (context, snapshot1) {
                        if (snapshot1.data == null) {
                          return Container(
                            width: 27,
                            height: 27,
                          );
                        }
                        if (snapshot1.data.count > 0) {
                          return Container(
                              width: 27,
                              height: 27,
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                snapshot1.data.count.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )));
                        }
                        return Container(
                          width: 27,
                          height: 27,
                        );
                      }),
                ),
              ),

              // trailing: Visibility(
              //       visible: (snapshot.data.role == "staff"),
              //       child: StreamBuilder<GetUnseenRequest>(
              //         stream: PageManager.getUnseenRequest(),
              //         builder: (context, snapshot1) {
              //           if (snapshot1.data == null) {
              //
              //             return Center(
              //                 child: CircularProgressIndicator(
              //                   backgroundColor: Colors.orange,
              //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //                 ));
              //           }
              //           return Visibility(
              //             visible: (snapshot1.data.count > 0),
              //             child: Container(
              //                 width: 27,
              //                 height: 27,
              //                 decoration: new BoxDecoration(
              //                   color: Colors.red,
              //                   shape: BoxShape.circle,
              //                 ),
              //                 child: Center(
              //                     child: Text(snapshot1.data?.count?.toString()??"-",
              //                   style: TextStyle(
              //                       fontSize: 14,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                 ))),
              //           );
              //         }
              //       ),
              //     ),

              //),
              // Text(
              //   snapshot1.data.count.toString(),
              //   style: TextStyle(fontSize: 16),
              // ),

              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Suggestion()));
                },
                leading: Icon(
                  Icons.sms,
                  color: Colors.orange,
                ),
                title: Text(
                  "Քննարկումներ",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                leading: Icon(
                  Icons.settings,
                  color: Colors.orange,
                ),
                title: Text(
                  "Անձնական էջ",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
                leading: Icon(
                  Icons.help,
                  color: Colors.orange,
                ),
                title: Text(
                  "Մեր մասին",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              ListTile(
                onTap: () {
                  UserSecureStorage.deletetall();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage1()));
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.orange,
                ),
                title: Text(
                  "Դուրս գալ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ]);
        });
  }

  Widget pickPicker(String fileName, Function onFilePicked) {
    return Positioned(
        right: -10.0,
        bottom: -10.0,
        child: IconButton(
          icon: Icon(
            Icons.add_a_photo,
            color: Colors.orange,
          ),
          onPressed: () {
            _imageFile = _picker.getImage(source: ImageSource.gallery);
            _imageFile.then((file) => {
                  this.setState(() {
                    onFilePicked(file);
                  })
                });
          },
        ));
  }
}
