import 'package:flutter/material.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getRequest.dart';

class RequestDetails extends StatefulWidget {
  final int id;

  const RequestDetails({Key key, this.id}) : super(key: key);
  @override
  _RequestDetailsState createState() => _RequestDetailsState(id);
}

class _RequestDetailsState extends State<RequestDetails> {
  final int id;
  bool isImage = false;

  _RequestDetailsState(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetRequest>(
        stream: PageManager.getRequest(),
        builder: (context, snapshot) {
          print("${id}  mejn ee");
          if (snapshot.data == null) {

            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          }
          if(snapshot.data.results[id].file != null){
            isImage = true;
            print("${snapshot.data.results[id].id} !!!!!!!!!");
          }
          return Scaffold(
            appBar: new AppBar(
              title: new Text('Մանրամասներ'),
              backgroundColor: Colors.orange,
              actions : <Widget>[IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){PageManager.deleteRequest(snapshot.data.results[id].id, context);})]
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Վերնագիր",
                      //   style: TextStyle(fontSize: 18),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(snapshot.data.results[id].title),
                      SizedBox(
                        height: 15,
                      ),
                      Text(snapshot.data.results[id].text),
                      SizedBox(
                        height: 10,
                      ),

                  Visibility(
                   visible: isImage,
                    child: Image.network(
                    isImage ? snapshot.data.results[id]?.file:"",
                      //width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.3,
                      ),
                  ),
                      SizedBox(height: 15,),
                      Divider(
                        height: 2,
                        //indent: 5,
                        thickness: 2,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.results[id].attachedToUserDetails
                                    ?.firstName !=
                                null
                            ? (snapshot.data.results[id].attachedToUserDetails
                                    ?.firstName +
                                " " +
                                snapshot.data.results[id].attachedToUserDetails
                                    ?.lastName)
                            : "",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(snapshot.data.results[id].answer == null
                          ? ""
                          : snapshot.data.results[id].answer),
                    ],
                  ),
                ),

            ),
          );
        });
  }
}
