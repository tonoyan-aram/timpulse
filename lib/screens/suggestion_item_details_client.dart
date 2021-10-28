import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/forumDetails.dart';
import 'package:tim/models/getMe.dart';

import '../costum_button.dart';

class SuggestionDetailsClient extends StatefulWidget {
  final int id;
  const SuggestionDetailsClient({Key key, this.id}) : super(key: key);
  @override
  _SuggestionDetailsClientState createState() =>
      _SuggestionDetailsClientState(id);
}

class _SuggestionDetailsClientState extends State<SuggestionDetailsClient> {
  final int id;
  int user;
  bool isText = false;
  TextEditingController answerController;
  String selectedChoise;
  int selectedChoiseId;
  bool is_active = false;
  int is_active1;
  bool _isLoaded = false;

  @override
  void initState() {
    _isLoaded = false;
    answerController = new TextEditingController();
    PageManager.getMe().listen((profile) {
      is_active1 = profile.status;
      if(is_active1 ==1){
        is_active = true;
      }
      user = profile.id;

    });
    print("${is_active1}  mejnne");
    print("${user} userrrrrrrr");

    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();

    super.dispose();
  }

  _SuggestionDetailsClientState(this.id);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ForumDetails>(
        stream: PageManager.getForumDetail(id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          }
          if(snapshot.data!=null){
            print("${snapshot.data.replyType} typeee");
            print("${is_active1}   is activve1");
            print("${is_active}   is activve");
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Scaffold(
              appBar: new AppBar(
                title: new Text("Մանրամասներ"),
                backgroundColor: Colors.orange,
              ),
              body: StreamBuilder<GetMe>(
                stream: PageManager.getMe(),
                builder: (context, snapshot1) {
                  if(snapshot1.data!=null){
                    print("${snapshot1.data.id} ------");
                    if(snapshot1.data.status == 1){
                      is_active = true;
                    }
                  }

                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data.replyType == "text") {
                          isText = true;
                        } else {
                          isText = false;
                        }
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ավարտ "),
                                    Text(
                                      DateFormat.yMd()
                                          .format(snapshot.data.endAt),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  snapshot.data.author,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  snapshot.data.text,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  height: 2,
                                  //indent: 5,
                                  thickness: 2,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Visibility(
                                    visible: snapshot.data.answeredByMe,
                                    child: Text("Դուք արդեն պատասխանել եք",style: TextStyle(color: Colors.deepOrange,fontSize: 16,fontWeight: FontWeight.bold),)),
                                Visibility(
                                  visible: is_active,
                                  child: Visibility(
                                    visible: !snapshot.data.answeredByMe,
                                    child: Visibility(
                                      visible: isText,
                                        child: _textInputLarge(
                                      controller: answerController,
                                      hint: "Պատասխան",
                                      icon: Icons.person,
                                      password: false,
                                    )),
                                  ),
                                ),
                                Visibility(
                                  visible: is_active,
                                  child: Visibility(
                                    visible: !snapshot.data.answeredByMe,
                                    child: Visibility(
                                      visible: !isText,
                                      child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.forumChoices.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Row(
                                              children: [
                                                Radio(
                                                    value: snapshot.data.forumChoices[index].id,
                                                    groupValue: selectedChoiseId,
                                                    onChanged: (val) {

                                                      setState(() {selectedChoiseId = val;});
                                                      print("${selectedChoiseId} typeee");
                                                    }),
                                                Expanded(
                                                    flex:5,
                                                    child: Text(snapshot.data.forumChoices[index].choice, maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,)),
                                              ],
                                            );
                                          }),),
                                  ),
                                )

,
                                SizedBox(height: 30,),
                                Visibility(
                                  visible: is_active,
                                  child: Visibility(
                                    visible: !snapshot.data.answeredByMe,
                                    child: Center(
                              child: !_isLoaded?ButtonWidget(
                                    btnText: "Ուղարկել",
                                    onClick: () {
                                      if(isText) {
                                        if (answerController.text.isNotEmpty) {
                                          setState(() {
                                            _isLoaded = true;
                                          });

                                          PageManager.postForumTextAnswer(
                                              id, answerController.text, snapshot1.data.id, context).listen((val) {setState(() {
                                                _isLoaded=false;
                                              });});
                                        }
                                      }
                                      if(!isText) {
                                        if (selectedChoiseId>0) {
                                          setState(() {
                                            _isLoaded = true;
                                          });
                                         // print("${id}  ${selectedChoiseId} ${user}  --------------===================");
                                          PageManager.postForumChoiceAnswer(id, selectedChoiseId, snapshot1.data.id, context).listen((val) {setState(() {
                                            _isLoaded = false;
                                          });});
                                        }
                                      }

                                    },
                              ):CircularProgressIndicator(
                                backgroundColor: Colors.orange,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                            ),
                                  ),
                                ),],
                            ),
                          ),
                        );
                      });
                }
              ),
            ),
          );
        });
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
}
