
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getRequest.dart';

import '../costum_button.dart';
import '../header_component.dart';
import 'add_request.dart';
import 'create_request.dart';
import 'home.dart';
import 'main_drower.dart';

class RequestForAdmin extends StatefulWidget {
  final int id;
  const RequestForAdmin({Key key, this.id}) : super(key: key);
  @override
  _RequestForAdminState createState() => _RequestForAdminState(id);
}

class _RequestForAdminState extends State<RequestForAdmin> {
  final int id;
  bool isImage = false;
  bool _isLoaded = false;

  _RequestForAdminState(this.id);
  TextEditingController controller;
  @override
  void initState() {
    _isLoaded = false;
    controller = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetRequest>(
        stream: PageManager.getRequest(),
        builder: (context, snapshot) {

          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),));
          }
          if(snapshot.data.results[id].file != null){
            isImage = true;
            print("${snapshot.data.results[id].file} !!!!!!!!!");
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Scaffold(
              appBar: new AppBar(
                title: new Text('Մանրամասներ'),
                backgroundColor: Colors.orange,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data.results[id].authorDetails.firstName+" "+snapshot.data.results[id].authorDetails.lastName,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        snapshot.data.results[id].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          snapshot.data.results[id].text),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: isImage,
                        child: Image.network(
                            isImage?snapshot.data.results[id]?.file:"",

                            height: MediaQuery.of(context).size.height*0.3),
                      ),
                      SizedBox(height: 15,),
                      Divider(
                        height: 2,
                        //indent: 5,
                        thickness: 2,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Պատասխան",
                          style: TextStyle(fontSize: 18),),
                      SizedBox(
                        height: 15,
                      ),
                      // stex bdi stugvi answeri null exnel@
                      snapshot.data.results[id].answer.isEmpty ?_textInputLarge(controller):Text(snapshot.data.results[id].answer),
                      SizedBox(
                        height: 20,
                      ),
                      snapshot.data.results[id].answer.isEmpty  ? Center(
                        child: !_isLoaded ? ButtonWidget(
                          btnText: "Պատասխանել",

                          onClick: () {
                            if(controller.text.length>0){
                              setState(() {
                                _isLoaded = true;
                              });
                              PageManager.postAnswerRequest(snapshot.data.results[id].id, controller.text).listen((val) {setState(() {
                                _isLoaded = false;
                                Navigator.pop(context);
                              });});

                            }

                          },
                        ):CircularProgressIndicator(
                        backgroundColor: Colors.orange,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                      ):Text(""),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _textInputLarge(controller) {
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
        //obscureText: password,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          // prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
