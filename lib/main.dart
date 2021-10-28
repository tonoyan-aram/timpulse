import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tim/functional/managment.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/screens/home.dart';
import 'package:tim/screens/loading.dart';
import 'package:tim/screens/log_in.dart';
import 'package:tim/splash_screen.dart';

import 'functional/user_secure_storage.dart';
import 'splash.dart';

int initScreen;
String pushToken;
String accesToken;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  accesToken = await UserSecureStorage().getUsername();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {
  String token;
  void initState(){
    super.initState();
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.orange));
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Splashh(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          //print("${accesToken} *****************");
          if (accesToken != null) {
            return StreamBuilder<GetMe>(
                stream: PageManager.getMe(),
                builder: (context, snapshot) {
                  //print("${snapshot.data} ///////////////");
                  return MaterialApp(
                    home: initScreen == 0 || initScreen == null
                        ? Onbording()
                        : (snapshot.connectionState == ConnectionState.waiting)
                            ? Loading()
                            : (snapshot.data == null)
                                ? LoginPage1()
                                : Home(),
                    debugShowCheckedModeBanner: false,
                  );
                });
          } else {
            return MaterialApp(
              home: initScreen == 0 || initScreen == null
                  ? Onbording()
                  : LoginPage1(),
              debugShowCheckedModeBanner: false,
            );
          }
          // Loading is done, return the app:

        }
      },
    );
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
    if(token!=null) {
      await UserSecureStorage.setPushToken(token);
     // PageManager.postToken(token);
    }
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(statusBarColor: Colors.white));
//     Widget splashscreen = SplashScreenView(
//       navigateRoute: Splash(),
//       duration: 2000,
//       imageSize: 180,
//       imageSrc: "assets/images/mainlogo.png",
//       text: "Բարի գալուստ",
//       textStyle: TextStyle(
//           fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.orange),
//       // textType: TextType.ColorizeAnimationText,
//       // textStyle: TextStyle(
//       //   fontSize: 40.0,
//       // ),
//       // textType: TextType.TyperAnimatedText,
//       // textStyle: TextStyle(
//       //   fontSize: 40.0,
//       // ),
//       // textType: TextType.ScaleAnimatedText,
//       // textStyle: TextStyle(
//       //   fontSize: 40.0,
//       // ),
//       colors: [
//         Colors.purple,
//         Colors.blue,
//         Colors.yellow,
//         Colors.red[400],
//       ],
//       backgroundColor: Colors.white,
//     );

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Splash screen ',
//       home: splashscreen,
//     );
//   }
// }
class Splashh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/icon.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
