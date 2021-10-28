import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/functional/user_secure_storage.dart';
import 'package:tim/screens/home.dart';
import 'package:tim/screens/recover.dart';
import 'package:tim/screens/registration.dart';


import '../costum_button.dart';
import '../header_component.dart';

class LoginPage1 extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage1> {
  TextEditingController password;
  TextEditingController email;
  bool _validate = true;
  bool _isLoaded = false;
  String psdError = "*Առնվազն 6 սիմվոլ";
  String emailError = "*Սխալ էլ․ հասցե";

  String loged1 = "";

  bool showEmailValidationMessage = true;

  @override
  void initState() {
    password = new TextEditingController();
    email = new TextEditingController();
    _isLoaded = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    password.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  // bool _obscureText = true;
  // String _password;
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderContainer(
                  "Մուտք", MediaQuery.of(context).size.height * 0.2),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _textInputemail(
                          controller: email,
                          hint: "Էլ․ հասցե",
                          icon: Icons.email,
                          password: false),
                      _textInput(
                          controller: password,
                          hint: "Գաղտնաբառ",
                          icon: Icons.vpn_key,
                          password: true),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Recover()));
                          },
                          child: Text(
                            "Վերականգնել գաղտնաբառը",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: !_isLoaded?ButtonWidget(
                            onClick: () {
                              print("${loged1} logeed exac te che");
                              //  login
                              validateByEmail();
                              setState(() {
                                (password.text.length >= 6)
                                    ? _validate = true
                                    : _validate = false;
                              });

                              if (_validate && showEmailValidationMessage) {
                                print("${_isLoaded} 1");
                                setState(() {
                                  _isLoaded = true;
                                });

                                print("${_isLoaded} 2");
                                PageManager().login(password.text, email.text, context).listen((event) {setState(() {
                                  _isLoaded = false;
                                }); });

                              }
                            },
                            btnText: "ՄՈւՏՔ",
                          ):CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Չունե՞ք անձնական էջ․"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegPage()));
                            },
                            child: Text(
                              "Գրանցվեք ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
          errorText: !_validate ? psdError : null,
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _textInputemail({controller, hint, icon, password}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        //validator: validateEmail,
        //onSaved: (value)=> _userName = value,
        obscureText: password,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorText: !showEmailValidationMessage ? emailError : null,
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  validateByEmail() {
    bool valid =
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(email.text) &&
            email.text.trim().isNotEmpty;
    setState(() {
      showEmailValidationMessage = valid;
    });
    print("${showEmailValidationMessage} emailll");
  }
}
