import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim/functional/functions.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/screens/home.dart';

import '../costum_button.dart';
import 'main_drower.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<PickedFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName;
  bool _isLoaded = false;

  String image;

  Future<PickedFile> _imageFile1;
  ImagePicker _picker1 = new ImagePicker();
  Function onFilePicked1;
  String fileName1;


  TextEditingController firstnameController;
  TextEditingController lastnameController;

  @override
  void initState() {
    firstnameController = new TextEditingController();
    _isLoaded = false;
    lastnameController = new TextEditingController();
    PageManager.getMe().listen((profile) {
      firstnameController.text = profile.firstName;
      lastnameController.text = profile.lastName;
      print("${profile.firstName}<<<!!!!!!!!!!!!!!<<<<");
    });

    super.initState();
  }

  @override
  void dispose() {
    firstnameController?.dispose();
    lastnameController?.dispose();

    super.dispose();
  }

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
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Scaffold(
              appBar: new AppBar(
                title: new Text('Անձնական էջ'),
                backgroundColor: Colors.orange,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(snapshot
                                          .data.image !=
                                      null
                                  ? "${FunctionalPage.urlapi}${snapshot.data.image}"
                                  : "https://www.kenyons.com/wp-content/uploads/2017/04/default-image.jpg"),
                            ),
                            pickPicker(fileName, (file) {
                              this.setState(() {
                                fileName = file.path.toString();

                                PageManager.editMyProfile(
                                    //snapshot.data.firstName,
                                    //snapshot.data.lastName,
                                   // snapshot.data.email,
                                    fileName,
                                    //snapshot.data.userSegments,
                                    context);
                                this.setState(() {});
                              });
                            })
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: CircleAvatar(
                        //     radius: 50.0,
                        //     backgroundImage: NetworkImage(
                        //       "${FunctionalPage.urlapi}${snapshot.data.image}" ??
                        //           "",
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          //color: Colors.red,
                          child: Center(
                              child: Text(
                            snapshot.data.status == 1 ? "Վերիֆիկացված" : "Նոր",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: snapshot.data.status == 1
                                ? Colors.green
                                : Colors.deepOrange,
                          ),
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _textInput(
                          controller: firstnameController,
                          disable: false,
                          hint: "Անուն",
                          icon: Icons.person,
                          password: false,
                        ),
                        _textInput(
                          controller: lastnameController,
                          disable: false,
                          hint: "Ազգանուն",
                          icon: Icons.person,
                          password: false,
                        ),
                        _textInput(
                            disable: true,
                            hint: "Էլ․ հասցե",
                            icon: Icons.email,
                            password: false,
                            value: snapshot.data.email),
                        SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: snapshot.data.hasWaitingVerificationRequest,
                          child: Text(
                            "Ձեր վերիֆիկացման հայտն ընթացքի մեջ է",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible: ((snapshot.data.status == 0) &&
                              !snapshot.data.hasWaitingVerificationRequest &&
                              (snapshot.data.role == "client")),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Վերիֆիկացման համար խնդրում ենք ուղարկել Ձեր ինքնանկարը՝ դեմքի կողքին անձնագիրը պահված",
                                style: TextStyle(fontSize: 16),
                              )),
                              pickPicker1(fileName1, (file) {
                                this.setState(() {
                                  fileName1 = file.path.toString();
                                  setState(() {
                                    PageManager.postFileVerification(fileName1, "ver",context)
                                        .listen((val) {
                                      setState(() {
                                        image = val.replaceAll('"', "");
                                      });
                                    });
                                  });
                                  print("${image}  image");

                                    // if(image.isNotEmpty)
                                    // {PageManager.sendVerification(
                                    //     snapshot.data.id, image, context);}
                                    // PageManager.sendVerification(
                                    //     snapshot.data.id, image, context);

                                });
                              })
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: !_isLoaded?ButtonWidget(
                            onClick: () {
                              setState(() {
                                _isLoaded = true;
                              });
                              print("${snapshot.data.userSegments} ....................");
                              //   print(
                              //      "${firstnameController.text}  --------!!!!--------   ${lastnameController.text}");
                              PageManager.editMyProfileNew(
                                  firstnameController.text,
                                  lastnameController.text,
                                  snapshot.data.email,
                                  snapshot.data.image,
                                  snapshot.data.userSegments,
                                  context,
                                  false,
                                  snapshot.data.clientEmployment,
                                  false).listen((val) {setState(() {
                                    _isLoaded=false;
                                  });});

                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => Home()));
                            },
                            btnText: "Փոփոխել",
                          ):CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              drawer: Drawer(
                child: MainDrawer(),
              ),
            ),
          );
        });
  }

  Widget _textInput(
      {hint, icon, password, String value, bool disable, controller}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        readOnly: disable,
        obscureText: password,
        //controller: controller,
        initialValue: value,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
          //suffixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget pickPicker(
    String fileName,
    Function onFilePicked,
  ) {
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

  Widget pickPicker1(String fileName, Function onFilePicked1) {
    return IconButton(
      icon: Icon(
        Icons.file_upload,
        color: Colors.green,
        size: 40,
      ),
      onPressed: () {
        _imageFile1 = _picker1.getImage(source: ImageSource.gallery);
        _imageFile1.then((file) => {
              this.setState(() {
                onFilePicked1(file);
              })
            });
      },
    );
  }
}
