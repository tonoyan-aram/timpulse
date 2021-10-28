import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tim/functional/functions.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getEmployment.dart';
import 'package:tim/models/getMe.dart';
//import 'package:tim/functional/managment.dart';
import 'package:tim/models/getSegmentlist.dart';
import 'package:tim/screens/home.dart';

import '../costum_button.dart';
import '../header_component.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {

  List<int> selecteCategorys =  [];

  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "5", "category_name": "Barber"},
      {"category_id": "3", "category_name": "Carpanter"},
      {"category_id": "7", "category_name": "Cook"}
    ],
    "responseTotalResult":
    3 // Total result is 3 here becasue we have 3 categories in responseBody.
  };

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        selecteCategorys.remove(category_id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      return  StreamBuilder<SegmentList>(
          stream: PageManager.getSegmentList(),
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
                        "Նախասիրություններ", MediaQuery.of(context).size.height * 0.2),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              value: selecteCategorys.contains(snapshot.data.results[index].id),
                              onChanged: (bool selected) {
                                _onCategorySelected(selected,
                                    snapshot.data.results[index].id);
                              },
                              title: Text(snapshot.data.results[index].name),
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

                              print(selecteCategorys);
                              // if(selecteCategorys.length>0){PageManager.editMyProfileNew(sdata.data.firstName, sdata.data.lastName, sdata.data.email, sdata.data.image ?? "", selecteCategorys, context,true, sdata.data.clientEmployment,false);
                              // }
                              if(selecteCategorys.length>0){PageManager.editMyProfileSegment(selecteCategorys, context,true, false);
                              }
                              print("elav");

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

