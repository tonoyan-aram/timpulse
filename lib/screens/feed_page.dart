import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/feedDetails.dart';
import 'package:tim/models/getFeeds.dart';

class FeedPage extends StatefulWidget {
  final int id;
  const FeedPage({Key key, this.id}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState(id);
}

class _FeedPageState extends State<FeedPage> {
  final int id;
  int currentIndex = 0;
  PageController _controller;
  final pageViewController = PageController();

  _FeedPageState(this.id);




  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(id);

    return StreamBuilder<FeedDetails>(
      stream: PageManager.getFeedDetail(id),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange, valueColor:AlwaysStoppedAnimation<Color>(Colors.white),));
        }
        return Scaffold(
          appBar: new AppBar(
            title: new Text('Մանրամասն'),
            backgroundColor: Colors.orange,
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: snapshot.data.feedImages.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [

                              Image.network(
                                snapshot.data.feedImages[i].image,

                                width: MediaQuery.of(context).size.width*0.8,
                                height: MediaQuery.of(context).size.height*0.3,
                                fit: BoxFit.cover,
                              ),
                             // SizedBox(height: 10),

                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      snapshot.data.feedImages.length,
                          (index) => buildDot(index, context),
                    ),
                  ),
                  SizedBox(height: 15,),
                  //SizedBox(height: 20,),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child:

                           Text(snapshot.data.text),

                        ),
                    ),
                    ),

                ],
              ),
            ),
            ),

        );
      }
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange,
      ),
    );
  }
}
