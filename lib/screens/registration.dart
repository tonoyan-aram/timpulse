import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/screens/log_in.dart';

import 'package:tim/screens/verification.dart';

import '../costum_button.dart';
import '../header_component.dart';

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController firstnameController;
  TextEditingController lastnameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController passwordconfirmController;
  bool _isLoaded = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded = false;
    firstnameController = new TextEditingController();
    lastnameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordconfirmController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordconfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(
                  "Գրանցում", MediaQuery.of(context).size.height * 0.2),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInputfirstName(
                        hint: "Անուն",
                        icon: Icons.person,
                        password: false,
                        controller: firstnameController),
                    _textInputlastName(
                        hint: "Ազգանուն",
                        controller: lastnameController,
                        icon: Icons.person,
                        password: false),
                    _textInputemail(
                        hint: "Էլ․ հասցե",
                        icon: Icons.email,
                        password: false,
                        controller: emailController),
                    _textInputpassword(
                        hint: "Գաղտնաբառ",
                        icon: Icons.vpn_key,
                        password: true,
                        controller: passwordController),
                    _textInputpassword(
                        hint: "Գաղտնաբառի կրկնություն",
                        controller: passwordconfirmController,
                        icon: Icons.vpn_key,
                        password: true),
                    SizedBox(height: 30),
                    Center(
                      child: !_isLoaded?ButtonWidget(
                        btnText: "ԳՐԱՆՑՈւՄ",
                        onClick: () {
                          setState(() {
                            (firstnameController.text.isEmpty)
                                ? _validate = true
                                : _validate = false;
                          });

                          (passwordController.text.isEmpty ||
                                  passwordconfirmController.text.isEmpty ||
                                  passwordController.text !=
                                      passwordconfirmController.text ||
                                  passwordController.text.length <= 5 ||
                                  passwordconfirmController.text.length <= 5)
                              ? _validate1 = true
                              : _validate1 = false;

                          lastnameController.text.isEmpty
                              ? _validate2 = true
                              : _validate2 = false;

                          validateByEmail();

                          if (!_validate &&
                              !_validate1 &&
                              !_validate2 &&
                              showEmailValidationMessage) {
                           setState(() {
                             _isLoaded = true;
                           });
                            PageManager.register(
                                passwordController.text,
                                passwordconfirmController.text,
                                emailController.text,
                                firstnameController.text,
                                lastnameController.text, context).listen((val) { setState(() {
                                  _isLoaded=false;
                                });});

                          }
                        },
                      ):CircularProgressIndicator(
                        backgroundColor: Colors.orange,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Ունե՞ք անձնական էջ․"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage1()));
                          },
                          child: Text(
                            "Մուտք",
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
            ],
          ),
        ),
      ),
    );
  }

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  String emailError = "*Սխալ էլ․ հասցե";
  bool showEmailValidationMessage = true;

  validateByEmail() {
    bool valid =
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(emailController.text) &&
            emailController.text.trim().isNotEmpty;
    setState(() {
      showEmailValidationMessage = valid;
    });
    print("${showEmailValidationMessage} emailll");
  }

  Widget _textInputfirstName({controller, hint, icon, password}) {
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
          prefixIcon: Icon(icon),
          errorText: _validate ? '*պարտադիր' : null,
        ),
      ),
    );
  }

  Widget _textInputlastName({controller, hint, icon, password}) {
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
          prefixIcon: Icon(icon),
          errorText: _validate2 ? '*պարտադիր' : null,
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
        keyboardType: TextInputType.emailAddress,
        obscureText: password,
        controller: controller,
        decoration: InputDecoration(
          errorText: !showEmailValidationMessage ? emailError : null,
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _textInputpassword({controller, hint, icon, password}) {
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
          prefixIcon: Icon(icon),
          errorText: _validate1 ? '*Առնվազն 6 սիմվոլ' : null,
        ),
      ),
    );
  }
}
