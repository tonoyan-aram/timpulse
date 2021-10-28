import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/functional/user_secure_storage.dart';
import 'package:tim/models/forumDetails.dart';
import 'package:tim/models/forumTextAnswer.dart';
import 'package:tim/models/getForum.dart';

import '../costum_button.dart';
import 'home.dart';

class SuggestionDetails extends StatefulWidget {
  final int id;
  const SuggestionDetails({Key key, this.id}) : super(key: key);

  @override
  _SuggestionDetailsState createState() => _SuggestionDetailsState(id);
}

class _SuggestionDetailsState extends State<SuggestionDetails> {
  final int id;
  bool isText;
  _SuggestionDetailsState(this.id);

  @override
  void initState() {
    super.initState();
  }

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


          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Scaffold(
              appBar: new AppBar(
                title: new Text("Մանրամասներ"),
                actions : <Widget>[IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){PageManager.deleteForum(id, context);})],
                backgroundColor: Colors.orange,
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {

                  if (snapshot.data.replyType == "text") {
                    isText = true;
                  } else {
                    isText = false;
                  }
                 // print(
                     // "${isText} \\\\\\\\\\\\\ ${snapshot.data.replyType} --------!!!!!!!");

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          Text(
                            "Պատասխաններ",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: isText,
                            child: StreamBuilder<ForumTextAnswer>(
                                stream: PageManager.getTextAnswer(id),
                                builder: (context, snapData) {
                                  if (snapData.data == null )
                                    return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ));

                                 if(snapData.data.results.isEmpty)
                                  {
                                    return Center(
                                      child: Text("Առայժմ պատասխան չկա",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange)),
                                    );
                                  }

                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapData.data.results.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapData.data.results[index]
                                                      .userDetails.firstName +
                                                  " " +
                                                  snapData.data.results[index]
                                                      .userDetails.lastName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.orangeAccent),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(snapData
                                                .data.results[index].text),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Divider(
                                              height: 2,
                                              //indent: 5,
                                              thickness: 2,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        );
                                      });
                                }),
                          ),
                          Visibility(
                            visible: !isText,
                            child: StreamBuilder<ForumDetails>(
                                stream: PageManager.getForumDetail(id),
                                builder: (context, snapData1) {
                                  if (snapData1.data == null )
                                    return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.orange,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ));
                                  if(snapData1.data.forumChoices.isEmpty)
                                  {
                                    return Center(
                                      child: Text("Առայժմ պատասխան չկա",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange)),
                                    );
                                  }

                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapData1.data.forumChoices.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               // crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(

                                                    flex :5,
                                                    child: Text(
                                                      snapData1.data.forumChoices[index].choice,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20,

                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex:1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 30),
                                                      child: Text(
                                                        snapData1.data.forumChoices[index].answerSum.toString(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.deepOrange),
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Divider(
                                              height: 2,
                                              //indent: 5,
                                              thickness: 2,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                          ],
                                        );
                                      });
                                }),
                          ),
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
}

Widget _answerButton(String title, BuildContext context) {
  return Container(
    child: ElevatedButton(
      child: Text(title),
      onPressed: () {},
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
