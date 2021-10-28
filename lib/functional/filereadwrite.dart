// import 'dart:convert';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:async';
//
// import 'package:tim/models/registration.dart';
// import 'package:tim/models/registrationfinal.dart';
//
//
// class FileReadWrite {
//
//   static Future<bool> saveLoggedUser(LoginverificationResponse loggedUser) async {
//     final appDirectory = await getApplicationDocumentsDirectory();
//     File file = File(appDirectory.path + "/login.txt");
//     file.writeAsString(jsonEncode(loggedUser));
//     return true;
//   }
//
// }
//
