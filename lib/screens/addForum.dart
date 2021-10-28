import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/models/getSegmentlist.dart';
import 'package:tim/screens/suggestion.dart';

import '../costum_button.dart';

class AddForum extends StatefulWidget {
  const AddForum({key}) : super(key: key);
  @override
  _AddForumState createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  String type = "text";
  bool visible = false;
  TextEditingController titleController;
  TextEditingController coiseController;
  TextEditingController dayController;
  DateTime date = DateTime.now();
  bool _isLoaded = false;

  @override
  void initState() {
    titleController = new TextEditingController();
    coiseController = new TextEditingController();
    dayController = new TextEditingController();
    _isLoaded = false;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    coiseController.dispose();
    dayController.dispose();
    super.dispose();
  }

  List<int> selecteCategorys = [];
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

  List<String> selectedChoises = [];
  void _onselectedChoises(choise_text) {
    setState(() {
      selectedChoises.add(choise_text);
    });
  }

  void _ondeleteChoises(choise_text) {
    setState(() {
      selectedChoises.remove(choise_text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SegmentList>(
        stream: PageManager.getSegmentList(),
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
                resizeToAvoidBottomInset: true,
                appBar: new AppBar(
                  title: new Text('Ստեղծել առաջարկ'),
                  backgroundColor: Colors.orange,
                ),
                body: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Հարցման տևողությունը",
                          style: TextStyle(fontSize: 16),
                        ),
                        _textInputDay(
                            controller: dayController, hint: "Տևողություն"),
                        Text(
                          "Ընտրեք նախասիրություններ",
                          style: TextStyle(fontSize: 16),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckboxListTile(
                                value: selecteCategorys
                                    .contains(snapshot.data.results[index].id),
                                onChanged: (bool selected) {
                                  _onCategorySelected(selected,
                                      snapshot.data.results[index].id);
                                },
                                title: Text(snapshot.data.results[index].name),
                              );
                            }),
                        Text(
                          "Հարց",
                          style: TextStyle(fontSize: 16),
                        ),
                        _textInputLarge(
                            controller: titleController,
                            hint: "Նկարագրություն",
                            icon: Icons.person,
                            password: false),
                        Text(
                          "Հարցի տեսակը",
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: [
                                Radio(
                                    value: "text",
                                    groupValue: type,
                                    onChanged: (val) {
                                      type = val;
                                      visible = false;
                                      setState(() {});
                                      print("${type} typeee");
                                    }),
                                Text("Տեքստային"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: "select",
                                    groupValue: type,
                                    onChanged: (val) {
                                      type = val;
                                      visible = true;
                                      setState(() {});
                                      print("${type} typeee");
                                    }),
                                Text("Տարբերակային"),
                              ],
                            ),
                          ],
                        ),
                        Visibility(
                          visible: visible,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // IconButton(
                              //     icon: Icon(
                              //       Icons.add,
                              //       color: Colors.orange,
                              //     ),
                              //     onPressed: () {
                              //       if (coiseController.text.isNotEmpty) {
                              //         _onselectedChoises(coiseController.text);
                              //         coiseController.text = "";
                              //       }
                              //       print(
                              //           "${selectedChoises}  selectedChoises");
                              //     }),
                              _textInput(
                                controller: coiseController,
                                hint: "Տարբերակ",
                                icon: Icons.person,
                                password: false,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: selectedChoises.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(selectedChoises[index]),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _ondeleteChoises(
                                                  selectedChoises[index]);
                                            })
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<GetMe>(
                            stream: PageManager.getMe(),
                            builder: (context, snapData) {
                              return Center(
                                child: !_isLoaded
                                    ? ButtonWidget(
                                        btnText: "Ուղարկել",
                                        onClick: () {
                                          if (coiseController.text.isNotEmpty) {
                                            _onselectedChoises(
                                                coiseController.text);
                                            coiseController.text = "";
                                          }
                                          if (dayController.text.isNotEmpty &&
                                              selecteCategorys.isNotEmpty &&
                                              titleController.text.isNotEmpty &&
                                              type == "text") {
                                            PageManager.postForum(
                                                titleController.text,
                                                null,
                                                type,
                                                null,
                                                date
                                                    .add(Duration(
                                                        days: int.parse(
                                                            dayController
                                                                .text)))
                                                    .toString(),
                                                snapData.data.id,
                                                selecteCategorys);
                                            print(
                                                "${selecteCategorys}  ${titleController.text}   ${type} ${selectedChoises}  ${snapData.data.id} ${date.add(Duration(days: int.parse(dayController.text)))}");
                                          }
                                          if (dayController.text.isNotEmpty &&
                                              selecteCategorys.isNotEmpty &&
                                              titleController.text.isNotEmpty &&
                                              selectedChoises.isNotEmpty &&
                                              type == "select") {
                                            setState(() {
                                              _isLoaded = true;
                                            });
                                            PageManager.postForum(
                                                    titleController.text,
                                                    null,
                                                    type,
                                                    selectedChoises,
                                                    date
                                                        .add(Duration(
                                                            days: int.parse(
                                                                dayController
                                                                    .text)))
                                                        .toString(),
                                                    snapData.data.id,
                                                    selecteCategorys)
                                                .listen((val) {
                                              setState(() {
                                                _isLoaded = false;
                                              });
                                            });
                                          }

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Suggestion()));
                                          final snackbar = SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "Ձեր հարցումն հաջողությամբ ստեղծվել է"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        },
                                      )
                                    : CircularProgressIndicator(
                                        backgroundColor: Colors.orange,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget _textInput({controller, hint, icon, password}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      //padding: EdgeInsets.only(left: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        obscureText: password,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              if (coiseController.text.isNotEmpty) {
                _onselectedChoises(coiseController.text);
                coiseController.text = "";
              }
              print("${selectedChoises}  selectedChoises");
            },
            icon: Icon(
              Icons.add,
              color: Colors.orange,
            ),
          ),
          border: InputBorder.none,
          hintText: hint,
          //prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

Widget _textInputDay({controller, hint}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    //padding: EdgeInsets.only(left: 10),
    padding: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
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
    height: 150,
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
