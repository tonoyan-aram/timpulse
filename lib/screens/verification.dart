import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';

import 'package:tim/screens/home.dart';
import 'package:tim/screens/preferences.dart';

import '../constants.dart';
import '../costum_button.dart';
import '../header_component.dart';

class OtpForm extends StatefulWidget {
  const OtpForm(
      {Key key,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.passwordconfirm})
      : super(key: key);
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String passwordconfirm;
  @override
  _OtpFormState createState() =>
      _OtpFormState(firstName, lastName, email, passwordconfirm, password);
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  bool _isLoaded = false;

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String passwordconfirm;
  String veryficationcode;

  _OtpFormState(this.firstName, this.lastName, this.email, this.passwordconfirm,
      this.password);

  @override
  void initState() {
    super.initState();
    _isLoaded = false;
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    veryficationcode = "";
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderContainer(
                        "Հաստատում", MediaQuery.of(context).size.height * 0.2),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      "Խնդրում ենք մուտքագրել Ձեր Էլ հասցեին ուղարկված հաստատման կոդը",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    //buildTimer(),
                    Form(
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    375,
                                child: TextFormField(
                                  autofocus: true,
                                  //obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    nextField(value, pin2FocusNode);
                                    veryficationcode += value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    375,
                                child: TextFormField(
                                    focusNode: pin2FocusNode,
                                    //obscureText: true,
                                    style: TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      border: outlineInputBorder(),
                                      focusedBorder: outlineInputBorder(),
                                      enabledBorder: outlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      nextField(value, pin3FocusNode);
                                      veryficationcode += value;
                                    }),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    375,
                                child: TextFormField(
                                    focusNode: pin3FocusNode,
                                    //obscureText: true,
                                    style: TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      border: outlineInputBorder(),
                                      focusedBorder: outlineInputBorder(),
                                      enabledBorder: outlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      nextField(value, pin4FocusNode);
                                      veryficationcode += value;
                                    }),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    375,
                                child: TextFormField(
                                  focusNode: pin4FocusNode,
                                  //obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: kTextColor),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      pin4FocusNode.unfocus();
                                      veryficationcode += value;
                                      // Then you need to check is the code is correct or not
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              //padding: EdgeInsets.only(top: 3, left: 3),
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(50),
                              //     border: Border(
                              //       bottom: BorderSide(color: Colors.black),
                              //       top: BorderSide(color: Colors.black),
                              //       left: BorderSide(color: Colors.black),
                              //       right: BorderSide(color: Colors.black),
                              //     )),
                              child: !_isLoaded?ButtonWidget(
                                onClick: () {
                                  if (veryficationcode.length == 4) {
                                    setState(() {
                                      _isLoaded = true;
                                    });
                                    PageManager.registerfinal(
                                        password,
                                        passwordconfirm,
                                        email,
                                        veryficationcode,
                                        firstName,
                                        lastName,
                                        context).listen((val) {setState(() {
                                          _isLoaded = false;
                                        }); });
                                    veryficationcode="";
                                    //dispose();

                                    // Home()));
                                  }
                                },
                                btnText: "ՄՈւՏՔ",
                              ):CircularProgressIndicator(
                                backgroundColor: Colors.orange,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    GestureDetector(
                      onTap: () {
                        if (veryficationcode.length == 4) {
                          PageManager.register(
                              password,
                              passwordconfirm,
                              email,
                              firstName,
                              lastName,
                              context);
                          veryficationcode="";
                        }

                        final snackbar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Ձեր կոդը հաջողությամբ ուղարկվել է"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        // OTP code resend
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        "Ուղարկել կոդը նորից",
                        //style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
