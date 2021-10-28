import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getEmployment.dart';
import 'package:tim/models/getMe.dart';

import '../costum_button.dart';
import '../header_component.dart';

class Employment extends StatefulWidget {
  @override
  _EmploymentState createState() => _EmploymentState();
}

class _EmploymentState extends State<Employment> {

  String selectedChoice;
  int selectedChoiceId;
  String firstName;

  void initState() {

    PageManager.getMe().listen((profile) {
      firstName = profile.firstName;
     print("${firstName} --------!!");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<EmploymentList>(
        stream: PageManager.getEmploymentList(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange, valueColor:AlwaysStoppedAnimation<Color>(Colors.white),));
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  HeaderContainer(
                      "Զբաղվածություն", MediaQuery.of(context).size.height * 0.2),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Radio(
                                  value: snapshot.data.results[index].id,
                                  groupValue: selectedChoiceId,
                                  onChanged: (val) {
                                    selectedChoiceId = val;


                                    setState(() {});
                                    print("${selectedChoiceId} typeee");
                                  }),
                              Expanded(
                                  flex:5,
                                  child: Text(snapshot.data.results[index].name, maxLines: 2,
                                    overflow: TextOverflow.ellipsis,)),
                            ],
                          );
                        }),
                  ),
                  StreamBuilder<GetMe>(
                      stream: PageManager.getMe(),
                      builder: (context, sdata) {
                        return Container(
                          padding: EdgeInsets.only(bottom: 20,left: 20, right: 20),
                          child: ButtonWidget(
                            btnText: "Հաստատել",
                            onClick: () {

                              print("${sdata} sss____________");
                              // if(selectedChoiceId > 0){PageManager.editMyProfileNew(sdata.data.firstName, sdata.data.lastName, sdata.data.email, sdata.data.image ?? "", null, context,true,selectedChoiceId,true);
                              // }
                              if(selectedChoiceId > 0){PageManager.editMyProfileEmployment(context,true,selectedChoiceId,true);
                              }

                            },
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}