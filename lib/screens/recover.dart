import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/screens/log_in.dart';

import '../costum_button.dart';
import '../header_component.dart';
import 'verification.dart';
import 'verification_email.dart';

class Recover extends StatefulWidget {
  @override
  _RecoverState createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {
  TextEditingController emailController;
  bool showEmailValidationMessage = true;
  String emailError = "*Սխալ էլ․ հասցե";
  bool _isLoaded = false;

  @override
  void initState() {
    emailController = new TextEditingController();
    _isLoaded = false;
    super.initState();
    //init();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: <Widget>[
              HeaderContainer(
                  "Վերականգնում", MediaQuery.of(context).size.height * 0.2),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Մուտքագրեք Ձեր Էլ․ հասցեն",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _textInput(hint: "Էլ․ հասցե",controller: emailController, icon: Icons.email),
                    SizedBox(
                      height: 50,
                    ),
                    !_isLoaded ? ButtonWidget(
                      onClick: () {
                        validateByEmail();
                        //print(showEmailValidationMessage);
                        if(showEmailValidationMessage){
                          setState(() {
                            _isLoaded = true;
                          });
                        PageManager.emailRecover(emailController.text, context).listen((val) {setState(() {
                          _isLoaded = false;
                        }); });


                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                             //   builder: (context) => OtpFormEmail(email: emailController.text)));
                        }

                        else{
                        final snackbar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Սխալ Էլ․ հասցե"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }

                      },
                      btnText: "Ուղարկել",
                    ):CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Text("Չունե՞ք անձնական էջ․"),
                        TextButton(
                          onPressed: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage1()));
                          },
                          child: Text(
                            "Գլխավոր էջ ",
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
  validateByEmail() {
    bool valid = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(emailController.text) && emailController.text.trim().isNotEmpty;
    setState(() {
      showEmailValidationMessage = valid;
    });
    print("${showEmailValidationMessage} emailll");
  }
}



Widget _textInput({controller, hint, icon}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
