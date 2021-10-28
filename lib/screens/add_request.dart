import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/functional/user_secure_storage.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/models/getStaffRole.dart';
import 'package:tim/models/postrequest.dart';
import 'package:tim/models/registrationfinal.dart';
import 'package:tim/models/staffUser.dart';

import '../costum_button.dart';
import 'request.dart';

class AddRequest extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  const AddRequest({key}) : super(key: key);

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  Future<PickedFile> _imageFile;
  ImagePicker _picker = new ImagePicker();
  Function onFilePicked;
  String fileName ;
  String image;
  bool uploaded = false;
  bool _isLoaded = false;

  TextEditingController nkaragrutyun;
  TextEditingController vernagir;

  @override
  void initState() {
    _isLoaded = false;
    vernagir = new TextEditingController();
    nkaragrutyun = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    vernagir.dispose();
    nkaragrutyun.dispose();
    super.dispose();
  }

  @override
  int value;
  int personValue;
  Widget build(BuildContext context) {
    return StreamBuilder<GetStaffRole>(
        stream: PageManager.getStaffRole(),
        builder: (context, snapshot) {
          print(snapshot.data);
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
              // key: _scaffoldKey,
              appBar: new AppBar(
                title: new Text('Ստեղծել հարցում'),
                backgroundColor: Colors.orange,
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Ընտրեք հասցեատիրոջը"),
                                value: value, // currently selected item
                                isExpanded: true,
                                items: snapshot.data.results
                                    .map((item) => DropdownMenuItem(
                                          child: Text(
                                            item.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          value: item.id,
                                        ))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  this.value = value;
                                  print(value);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: StreamBuilder<StaffUser>(
                                  stream: PageManager.getStaffUser(value),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            hint: Text("Ընտրեք մասնագետին")),
                                      );
                                      // Center(child: CircularProgressIndicator(backgroundColor: Colors.orange, valueColor:AlwaysStoppedAnimation<Color>(Colors.white),));
                                    }
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("Ընտրեք մասնագետին"),
                                        isExpanded: true,
                                        value:
                                            personValue, // currently selected item
                                        items: snapshot.data.results
                                            .map((item) => DropdownMenuItem(
                                                  child: Text(
                                                    item.firstName +
                                                        " " +
                                                        item.lastName,overflow: TextOverflow.ellipsis,
                                                  ),
                                                  value: item.id,
                                                ))
                                            .toList(),
                                        onChanged: (value) => setState(() {
                                          this.personValue = value;
                                          print(value);
                                        }),
                                      ),
                                    );
                                  })),
                          _textInput(
                              controller: vernagir,
                              hint: "Վերնագիր",
                              icon: Icons.person,
                              password: false),
                          _textInputLarge(
                              controller: nkaragrutyun,
                              hint: "Նկարագրություն",
                              icon: Icons.person,
                              password: false),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Կցել նկար",style: TextStyle(fontSize: 16),),
                              pickPicker(fileName, (file) {
                                this.setState(() {
                                  fileName = file.path.toString();
                                  PageManager.postFile(fileName,"req").listen((value) {setState(() {
                                    image = value.replaceAll('"', ""); uploaded = true;
                                  });});

                                });
                              }),
                              
                            ],
                          ),
                          Visibility(
                              visible: uploaded,
                              child: Text("*Նկարը կցված է",style: TextStyle(color: Colors.red,fontSize: 10),)),
                          SizedBox(height: 30),
                          StreamBuilder<GetMe>(
                              stream: PageManager.getMe(),
                              builder: (context, snapData) {
                                return Center(
                                  child: !_isLoaded?ButtonWidget(
                                    btnText: "Ուղարկել",
                                    onClick: () {
                                      if(
                                      vernagir!=null && value!=null &&personValue!=null && nkaragrutyun!=null
                                      ){
                                        setState(() {
                                          _isLoaded=true;
                                        });
                                        PageManager.postRequest(
                                          snapData.data.id,
                                          vernagir.text,
                                          image,
                                          value,
                                          personValue,
                                          nkaragrutyun.text).listen((val) {setState(() {
                                            _isLoaded=false;
                                          });});
                                      //print("${snapData.data.id} ${vernagir.text} ${value} ${personValue} ${nkaragrutyun.text}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Request()));
                                      final snackbar = SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            "Ձեր հարցումն հաջողությամբ ստեղծվել է"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);}

                                    },
                                  ):CircularProgressIndicator(
                                    backgroundColor: Colors.orange,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  Widget pickPicker(String fileName, Function onFilePicked) {
    return IconButton(
      icon: Icon(
        Icons.file_upload,
        color: Colors.green,

      ),
      onPressed: () {
        _imageFile = _picker.getImage(source: ImageSource.gallery);
        _imageFile.then((file) => {
          this.setState(() {
            onFilePicked(file);
          })
        });
      },
    );
  }
}

Widget _textInput({controller, hint, icon, password}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      obscureText: password,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        //prefixIcon: Icon(icon),
      ),
    ),
  );
}

Widget _textInputLarge({controller, hint, icon, password}) {
  return Container(
    height: 200,
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      maxLines: 9,
      obscureText: password,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        // prefixIcon: Icon(icon),
      ),
    ),
  );
}
