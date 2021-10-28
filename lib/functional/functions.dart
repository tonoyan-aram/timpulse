import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tim/models/addForum.dart';
import 'package:tim/models/answerRequest.dart';
import 'package:tim/models/checkEmailRecover.dart';
import 'package:tim/models/deleteRequest.dart';
import 'package:tim/models/emailRecover.dart';
import 'package:tim/models/feedDetails.dart';
import 'package:tim/models/forumChoiseAnswer.dart';
import 'package:tim/models/forumDetails.dart';
import 'package:tim/models/forumTextAnswer.dart';
import 'package:tim/models/getEmployment.dart';
import 'package:tim/models/getFeeds.dart';
import 'package:tim/models/getForum.dart';
import 'package:tim/models/getMe.dart';
import 'package:tim/models/getRequest.dart';
import 'package:tim/models/getSegmentlist.dart';
import 'package:tim/models/getStaffRole.dart';
import 'package:tim/models/getUnseenRequest.dart';
import 'package:tim/models/login.dart';
import 'package:tim/models/postEditProfile.dart';
import 'package:tim/models/postFile.dart';
import 'package:tim/models/postToken.dart';
import 'package:tim/models/postVerification.dart';
import 'package:tim/models/postrequest.dart';

import 'dart:async';

import 'package:tim/models/registration.dart';
import 'package:tim/models/registrationfinal.dart';
import 'package:tim/models/setUnseenRequest.dart';
import 'package:tim/models/staffUser.dart';
import 'package:tim/screens/employment.dart';
import 'package:tim/screens/home.dart';
import 'package:tim/screens/log_in.dart';
import 'package:tim/screens/preferences.dart';
import 'package:tim/screens/profile.dart';
import 'package:tim/screens/request.dart';
import 'package:tim/screens/suggestion.dart';
import 'package:tim/screens/verification.dart';
import 'package:tim/screens/verification_email.dart';

import 'user_secure_storage.dart';

class FunctionalPage {
  static String urlapi = "https://gov.annaniks.com";

  //todo***********
  static Future<Registration> registration(
      String password,
      String confirmPassword,
      String email,
      String firstName,
      String lastName,
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "password": password,
      "confirm_password": confirmPassword,
      "email": email,
      "first_name": firstName,
      "last_name": lastName
    };
    // print("${body}   bodyyy");
    http.Response response = await http
        .post(Uri.parse("${urlapi}/users/send-registration-code/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });
    //print("${response.body}------------response");
    final data = response.body;
    if (data == '[{"message":"Email already in use"}]') {
      // print("dzeccc");
    }

    // print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      print(response.statusCode);
      registrationFromJson(responseString);

      // print(responseString + "sdffffffffff");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpForm(
                    password: password,
                    email: email,
                    passwordconfirm: confirmPassword,
                    firstName: firstName,
                    lastName: lastName,
                  )));
    } else if (data == '[{"message":"Email already in use"}]') {
      _showAlertExistEmail(context);
    } else {
      _showAlertDialogreg(context);
    }
    return null;
  }

  static Future<EmailRecover> emailREcover(
      String email, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"email": email};
    // print("${body}   bodyyy");
    http.Response response = await http
        .post(Uri.parse("${urlapi}/users/send-forget-code-email/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    final data = response.body;

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;

      registrationFromJson(responseString);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpFormEmail(email: email)));
    } else
      _showAlertDialogemail(context);
    return null;
  }

  static Future<CheckEmailRecover> checkEmailREcover(
      String email, String confirmCode, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"email": email, "confirm_code": confirmCode};
    // print("${body}   bodyyy");
    http.Response response = await http
        .post(Uri.parse("${urlapi}/users/check-forget-code-email/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    final data = response.body;
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;

      registrationFromJson(responseString);
      _showAlertDialogemailcodok(context);
    } else
      _showAlertDialogemailcod(email, context);
    return null;
  }

  // todo**************
  Future<LoginverificationResponse> login(
      String password, String email, BuildContext context) async {
    String pushToken = await UserSecureStorage().getPushToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"password": password, "email": email};

    http.Response response = await http
        .post(Uri.parse("${urlapi}/users/login-user/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    final data = response.body;
    print(response.statusCode);


    if (response.statusCode == 201 || response.statusCode == 200) {
      print("${pushToken}  pushhh");

      await UserSecureStorage.setUserLoged("loged");
     // String responseString = response.body;
      await UserSecureStorage.deletetall();
      await UserSecureStorage.setUserid(
          LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .id
              .toString());
      await UserSecureStorage.setUserrole(
          LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .role);
      String accessToken =
          LoginverificationResponse.fromJson(json.decode(response.body)).access;
      await UserSecureStorage.setUsername(accessToken);

      postToken(pushToken);

      if(LoginverificationResponse.fromJson(json.decode(response.body))
          .user.role == "client"){
        if (LoginverificationResponse.fromJson(json.decode(response.body))
            .user
            .userSegments !=
            null) {
          await UserSecureStorage.setSegment("ok");
        }
      }

      String segmentik = await UserSecureStorage().getSegment();
     // print("${segmentik} segmentikk");


      // String accessTokenSt = await UserSecureStorage().getUsername();
      if(LoginverificationResponse.fromJson(json.decode(response.body))
          .user.role == "client"){
        if (LoginverificationResponse.fromJson(json.decode(response.body))
            .user
            .clientEmployment ==
            null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employment()));
        } else if (LoginverificationResponse.fromJson(json.decode(response.body))
            .user
            .userSegments.isEmpty) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Preferences()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          return LoginverificationResponse.fromJson(json.decode(response.body));
        }
      }
       else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        return LoginverificationResponse.fromJson(json.decode(response.body));
      }
    } else {
      _showAlertDialog(context);
    }
    return null;
  }

  static Future<LoginverificationResponse> registrationfinal(
      String password,
      String confirmpassword,
      String email,
      String confirmcode,
      String firstName,
      String lastName,
      BuildContext context) async {
    String pushToken = await UserSecureStorage().getPushToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "password": password,
      "confirm_password": confirmpassword,
      "email": email,
      "confirm_code": confirmcode,
      "first_name": firstName,
      "last_name": lastName
    };

    http.Response response = await http
        .post(Uri.parse("${urlapi}/users/register-user/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    // final data = response.body;
    //print(response.statusCode);

    // print(data);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("${pushToken} pushregistri vaxt");
      String responseString = response.body;
      await UserSecureStorage.deletetall();
      await UserSecureStorage.setUserid(
          LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .id
              .toString());
      await UserSecureStorage.setUserrole(
          LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .role);
      await UserSecureStorage.setUsername(
          LoginverificationResponse.fromJson(json.decode(response.body))
              .access);
      postToken(pushToken);
      if (LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .userSegments.isEmpty) {
        await UserSecureStorage.setSegment("ok");
      }if (LoginverificationResponse.fromJson(json.decode(response.body))
              .user
              .userSegments.isEmpty) {
        await UserSecureStorage.setSegment("ok");
      }
      registrationfinalFromJson(responseString);
      print(response.statusCode);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Employment()));
    } else {
      _showAlertDialogCode(password, confirmpassword, email, confirmcode,
          firstName, lastName, context);
    }
    return null;
  }

  //todo exac e
  static Future<SegmentList> getSegmentList() async {
    http.Response response = await http.get(
      Uri.parse("${urlapi}/utils/segment/?offset=0&limit=50"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
    );
    print(response.statusCode);

    String responseString = utf8.decode(response.bodyBytes).toString();

    // String responseString = response.body;
    SegmentList h = segmentListFromJson(responseString);
    return h;
  }

  static Future<EmploymentList> getEmploymentList() async {
    http.Response response = await http.get(
      Uri.parse("${urlapi}/utils/employment/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
    );
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      //String responseString = response.body;
      String responseString = utf8.decode(response.bodyBytes).toString();

      EmploymentList h = employmentListFromJson(responseString);
      return h;
    }
  }

  //todo exac
  static Future<GetMe> getMe() async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      Uri.parse("${urlapi}/users/get-me/"),
      headers: headers,
    );

    final data = response.body;
    // debugPrint(response.request.url.toString());
    // debugPrint(data);
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      //String responseString = response.body;
      String responseString = utf8.decode(response.bodyBytes).toString();

      GetMe h = getMeFromJson(responseString);
      return h;
      //return info.map((json) => getMeFromJson(json));
    }
  }

  static Future<GetUnseenRequest> getUnseenRequest() async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      Uri.parse("${urlapi}/request/request/attached-request-count/"),
      headers: headers,
    );


    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      GetUnseenRequest h = getUnseenRequestFromJson(responseString);
      return h;

    }
  }

  static Future<SetUnseenRequest> setUnseenRequest(int id) async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      Uri.parse("${urlapi}/request/request/$id/set-request-seen/"),
      headers: headers,
    );


    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      SetUnseenRequest h = setUnseenRequestFromJson(responseString);
      return h;

    }
  }

  //todo exac e
  static Future<Feed> getFeeds() async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/feed/feed/?offset=0&limit=1000"),
      headers: headers,
    );

    String responseString = utf8.decode(response.bodyBytes).toString();
    Feed h = feedFromJson(responseString);
    return h;
  }

  static Future<Forum> getForum() async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/forum/forum/?offset=0&limit=100000"),
      headers: headers,
    );

    //final data = response.body;
    // debugPrint(response.request.url.toString());
    // debugPrint(data);
    // print("${response.statusCode} statusss in forums");

    if (response.statusCode == 201 || response.statusCode == 200) {
      //String responseString = response.body;
      String responseString = utf8.decode(response.bodyBytes).toString();
      Forum h = forumFromJson(responseString);
      return h;
    }
  }

  // /request/request/30/
  static Future<DeleteRequest> deleteRequest(
      int id, BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.delete(
      Uri.parse("${urlapi}/request/request/$id/"),
      headers: headers,
    );
    print("${response.statusCode}   ------------------");
    if (response.statusCode == 204) {
      _showAlertDialogDeleteRequest(context);
    }
    String responseString = utf8.decode(response.bodyBytes).toString();

    DeleteRequest h = deleteRequestFromJson(responseString);
    return h;
  }

  static Future<DeleteRequest> deleteForum(int id, BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.delete(
      Uri.parse("${urlapi}/forum/forum/$id/"),
      headers: headers,
    );
    print("${response.statusCode}   ------------------");
    if (response.statusCode == 204) {
      _showAlertDialogDeleteForum(context);
    }
    String responseString = utf8.decode(response.bodyBytes).toString();

    DeleteRequest h = deleteRequestFromJson(responseString);
    return h;
  }

  static Future<ForumDetails> getForumDetail(int id) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/forum/forum/$id/"),
      headers: headers,
    );
    String responseString = utf8.decode(response.bodyBytes).toString();

    ForumDetails h = forumDetailsFromJson(responseString);
    return h;
  }

  //todo exac e
  static Future<GetRequest> getRequest() async {
    String accessToken = await UserSecureStorage().getUsername();
    String id = await UserSecureStorage().getUserid();
    String role = await UserSecureStorage().getUserrole();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = role == "client"
        ? await http.get(
            Uri.parse(
                "${urlapi}/request/request/?author=$id&offset=0&limit=1000"),
            headers: headers,
          )
        : await http.get(
            Uri.parse(
                "${urlapi}/request/request/?attached_to=$id&offset=0&limit=1000"),
            headers: headers,
          );

    final data = response.body;
    //debugPrint(response.request.url.toString());
    //debugPrint(data);
    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();
      GetRequest h = requestFromJson(responseString);
      return h;
    }
  }

  static Future<FeedDetails> getFeedDetail(int id) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',

      // 'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/feed/feed/$id/"),
      headers: headers,
    );
    String responseString = utf8.decode(response.bodyBytes).toString();

    FeedDetails h = feedDetailsFromJson(responseString);
    return h;
  }

  static Future<ForumTextAnswer> getTextAnswer(int id) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',

      // 'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/forum/forum-answer/?forum=$id"),
      headers: headers,
    );
    String responseString = utf8.decode(response.bodyBytes).toString();

    ForumTextAnswer h = forumTextAnswerFromJson(responseString);
    return h;
  }

  static Future<StaffUser> getStaffUser(int id) async {
    String accessToken = await UserSecureStorage().getUsername();
    // print(accessToken);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',

      // 'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse("${urlapi}/users/user/?staff_role=$id&offset=0&limit=1000"),
      headers: headers,
    );
    String responseString = utf8.decode(response.bodyBytes).toString();

    StaffUser h = staffUserFromJson(responseString);
    return h;
  }

  //todo exac e
  static Future<GetStaffRole> getStaffRole() async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    http.Response response = await http.get(
      Uri.parse("${urlapi}/utils/staff-role/?offset=0&limit=100"),
      headers: headers,
    );

    final data = response.body;

    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      GetStaffRole h = getStaffRoleFromJson(responseString);
      return h;
    }
  }

  //todo exac e
  static Future<PostRequest> postRequest(int author, String title, String file,
      int staffrole, int userId, String text) async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {
      "author": author,
      "title": title,
      "file": file,
      "staff_role": staffrole,
      "attache_to_by_user": userId,
      "text": text,
    };

    http.Response response = await http.post(
        Uri.parse("${urlapi}/request/request/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      return postRequestFromJson(responseString);
    } else
      return null;
  }

  static Future<PostToken> postToken( String token) async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {
      "push_token": token,
    };

    http.Response response = await http.post(
        Uri.parse("${urlapi}/users/save-push-token/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    print("${response.statusCode}  pushistatus");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("ok");
      String responseString = response.body;
      return postTokenFromJson(responseString);
    } else
      return null;
  }

  static Future<ForumTextAnswer> postForumTextAnswer(
      int forum, String text, int user, BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {"forum": forum, "text": text, "user": user};

    http.Response response = await http.post(
        Uri.parse("${urlapi}/forum/forum-answer/?offset=0&limit=1000/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;

      _showAlertDialogeditForumAnswer(context);

      return forumTextAnswerFromJson(responseString);
    } else
      return null;
  }

  static Future<ForumChoiseAnswer> postForumChoiceAnswer(
      int forum, int choice, int user, BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {"forum": forum, "choice": choice, "user": user};

    http.Response response = await http.post(
        Uri.parse("${urlapi}/forum/forum-choice-answer/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;

      _showAlertDialogeditForumAnswer(context);

      return forumChoiseAnswerFromJson(responseString);
    } else
      return null;
  }

  static Future<AddForum> postForum(String text, String file, String replyType,
      List forumChoices, String endAt, int author, List segment) async {
    String accessToken = await UserSecureStorage().getUsername();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {
      "text": text,
      "file": file,
      "reply_type": replyType,
      "forum_choices": forumChoices,
      "end_at": endAt,
      "author": author,
      "segment": segment
    };

    //print(body);

    http.Response response = await http.post(
        Uri.parse("${urlapi}/forum/forum/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      return addForumFromJson(responseString);
    } else
      return null;
  }

  static Future<AnswerRequest> postAnswerRequest(int id, String text) async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {
      "author": id,
      "answer": text,
    };

    //print("${id} answerr iddddd");
    //print("${text} answerr text");

    http.Response response = await http.post(
        Uri.parse("${urlapi}/request/answer-request/$id/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      return answerRequestFromJson(responseString);
    } else
      return null;
  }

  static Future<MyProfile> editMyProfileNew(
      String firstName,
      String lastName,
      String email,
      String image,
      List<dynamic> preference,
      BuildContext context,
      bool from,
      int employment,
      bool employmentFrom) async {
    String accessToken = await UserSecureStorage().getUsername();
    String segment = await UserSecureStorage().getSegment();
    print("${segment} editi meji segmentik");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body1 = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "client_employment": employment
    };

    Map body = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "user_segments": preference,
      "client_employment": employment
    };

    //print(body);
    http.Response response = await http.put(
        Uri.parse("${urlapi}/users/edit-my-personal-details/"),
        headers: headers,
        body: (segment == "ok") ? jsonEncode(body1) : jsonEncode(body));
    final data = response.body;
    //debugPrint(data);

    print("${response.statusCode}    statusss");
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      print(
          "${MyProfile.fromJson(json.decode(response.body)).userSegments} preferenci mejjjj segment");
      print(
          "${segment} preferenci mejjjj");
      if (employmentFrom && (segment == "ok")) {
        print("1");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Preferences()));
      } else if (employmentFrom && (segment != "ok")) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (from) {
        print("2");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      if (!from) {
        _showAlertDialogedit(context);
      }
      return myProfileFromJson(responseString);
    } else
      return null;
  }
  static Future<MyProfile> editMyProfileEmployment(

      BuildContext context,
      bool from,
      int employment,
      bool employmentFrom) async {
    String accessToken = await UserSecureStorage().getUsername();
    String segment = await UserSecureStorage().getSegment();
    print("${segment} editi meji segmentik");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body= {

      "client_employment": employment
    };



    //print(body);
    http.Response response = await http.put(
        Uri.parse("${urlapi}/users/edit-my-personal-details/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;
    //debugPrint(data);

    print("${response.statusCode}    statusss");
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      print(
          "${MyProfile.fromJson(json.decode(response.body)).userSegments} preferenci mejjjj segment");
      print(
          "${segment} preferenci mejjjj");

      if (employmentFrom && (segment == "ok")) {
        print("1");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Preferences()));
      } else if (employmentFrom && (segment != "ok")) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (from) {
        print("2");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }

      if (!from) {
        _showAlertDialogedit(context);
      }
      return myProfileFromJson(responseString);
    } else
      return null;
  }
  static Future<MyProfile> editMyProfileSegment(

      List<dynamic> preference,
      BuildContext context,
      bool from,
      bool employmentFrom) async {
    String accessToken = await UserSecureStorage().getUsername();
    String segment = await UserSecureStorage().getSegment();
    print("${segment} editi meji segmentik");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    Map body = {
      "user_segments": preference,
    };

    //print(body);
    http.Response response = await http.put(
        Uri.parse("${urlapi}/users/edit-my-personal-details/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;
    //debugPrint(data);

    print("${response.statusCode}    statusss");
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      print(
          "${MyProfile.fromJson(json.decode(response.body)).userSegments} preferenci mejjjj segment");
      print(
          "${segment} preferenci mejjjj");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));

      if (!from) {
        _showAlertDialogedit(context);
      }
      return myProfileFromJson(responseString);
    } else
      return null;
  }

  //todo exac e
  static Future<MyProfile> editMyProfile(String image,  BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };
    Map<String, String> body = {
      //"first_name": firstName,
      //"last_name": lastName,
      //"email": email,
      // "user_segments": preference,
    };
    var request = http.MultipartRequest(
        'PUT', Uri.parse("${urlapi}/users/edit-my-personal-details/"));
    request.headers.addAll(headers);
    // try {
    //   request.fields.addAll(body);
    //   for (int i = 0; i < preference.length; i++) {
    //     request.fields['user_segments[$i]'] = '${preference[i]}';
    //   }
    // } catch (e) {
    //   print(e);
    // }

    request.files.add(http.MultipartFile(
        'image', File(image).readAsBytes().asStream(), File(image).lengthSync(),
        filename: image.split("/").last));

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));

      var d = jsonDecode(responseString);
      return d;
    } else
      var d = jsonDecode(responseString);
    return null;
  }

  static Future<Verification> sendVerification(
      int user, String image, BuildContext context) async {
    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };
    Map body = {"user": user, "file": image};

    //print("${id} answerr iddddd");
    //print("${text} answerr text");

    http.Response response = await http.post(
        Uri.parse("${urlapi}/users/verification-request/"),
        headers: headers,
        body: jsonEncode(body));
    final data = response.body;
    print("${response.statusCode} status in verification");

    if (response.statusCode == 201 || response.statusCode == 200) {
      _showAlertDialogVerification(context);
      String responseString = data; //response.body;
      return checkVerificationFromJson(responseString);
    } else
      return null;
  }

  static Future<String> postFile(String file, String from) async {
    int id = int.parse(await UserSecureStorage().getUserid());

    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };
    // Map<String, dynamic> body = {
    //   "user": user,
    //
    //   // "user_segments": preference,
    // };

    var request =
        http.MultipartRequest('POST', Uri.parse("${urlapi}/files/files/"));

    request.headers.addAll(headers);

    request.files.add(http.MultipartFile('file_url',
        File(file).readAsBytes().asStream(), File(file).lengthSync(),
        filename: file.split("/").last));
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print("${responseString} +++++++");


    if (response.statusCode == 201 || response.statusCode == 200) {
      if (responseString != null) {

        String newRespons = responseString.replaceAll('"', "");


      }
      return responseString;

    } else

      return null;
  }

  static Future<String> postFileVerification(String file, String from, BuildContext context) async {
    int id = int.parse(await UserSecureStorage().getUserid());

    String accessToken = await UserSecureStorage().getUsername();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };
    // Map<String, dynamic> body = {
    //   "user": user,
    //
    //   // "user_segments": preference,
    // };
    print("1");
    var request =
    http.MultipartRequest('POST', Uri.parse("${urlapi}/files/files/"));
    print("2");
    request.headers.addAll(headers);
    print("3");
    request.files.add(http.MultipartFile('file_url',
        File(file).readAsBytes().asStream(), File(file).lengthSync(),
        filename: file.split("/").last));
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print("${responseString} +++++++");


    if (response.statusCode == 201 || response.statusCode == 200) {
      String newRespons = responseString.replaceAll('"', "");
      sendVerification(id,newRespons,context);
      _showAlertDialogVerification(context);


      return responseString;

    } else

      return null;
  }
}




void _showAlertDialog(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Սխալ մուտքանուն"),
    content: Text("Խնդրում ենք մուտքագրել ճիշտ էլ. հասցե և  գաղտնաբառ"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogCode(
    String password,
    String confirmpassword,
    String email,
    String confirmcode,
    String firstName,
    String lastName,
    BuildContext context) {
  final alert = AlertDialog(
    title: Text("Սխալ կոդ"),
    content: Text("Խնդրում ենք մուտքագրել ճիշտ կոդը"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpForm(
                        password: password,
                        email: email,
                        passwordconfirm: confirmpassword,
                        firstName: firstName,
                        lastName: lastName,
                      ))))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogreg(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Սխալ տվյալներ"),
    content: Text("Խնդրում ենք մուտքագրել ճիշտ տվյալներ"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogemail(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Սխալ էլ. հասցե"),
    content: Text("Խնդրում ենք մուտքագրել ճիշտ էլ. հասցե"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogemailcod(String email, BuildContext context) {
  final alert = AlertDialog(
    title: Text("Սխալ կոդ"),
    content: Text("Խնդրում ենք մուտքագրել ճիշտ կոդը"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpFormEmail(email: email))))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogemailcodok(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհավորում ենք"),
    content: Text("Ձեր նոր գաղտնաբառն ուղարկվել է Ձեր էլ. հասցեին"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage1())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertExistEmail(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Ուշադրություն"),
    content: Text("Տվյալ էլ. հասցեով օգտատեր արդեն գրանցված է"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogedit(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհավորում ենք"),
    content: Text("Ձեր տվյալները հաջողությամբ փոփոխված են"),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogeditForumAnswer(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհակալություն"),
    content: Text("Ձեր պատասխանն ընդունված է"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Suggestion())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogVerification(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհակալություն"),
    content: Text("Ձեր նկարն ընդունված է"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogDeleteRequest(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհակալություն"),
    content: Text("Ձեր հարցումն հաջողությամբ ջնջված է"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Request())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogDeleteForum(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհակալություն"),
    content: Text("Ձեր հարցումն հաջողությամբ ջնջված է"),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Suggestion())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
