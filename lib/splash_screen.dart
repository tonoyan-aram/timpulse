import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'content_model.dart';
import 'screens/log_in.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  PageController _controller;

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
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
                         
                          Image.asset(
                            contents[i].image,
                            height: MediaQuery.of(context).size.height * 0.45,
                            //fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            contents[i].title,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (index) => buildDot(index, context),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 60,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            primary: Colors.white,
                            //minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                            ),
                          ),
                          child: Text(
                            currentIndex == contents.length - 1
                                ? "Մուտք"
                                : "Առաջ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            if (currentIndex == contents.length - 1) {
                              _storeOnboardInfo();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage1(),
                                ),
                              );
                            }
                            _controller.nextPage(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.bounceIn,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
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
