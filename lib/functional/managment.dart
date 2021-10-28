import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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
import 'package:tim/models/registration.dart';
import 'package:tim/models/registrationfinal.dart';
import 'package:tim/models/setUnseenRequest.dart';
import 'package:tim/models/staffUser.dart';
//import 'package:tim/screens/login_signout.dart';
import 'filereadwrite.dart';
import 'package:tim/functional/functions.dart';

import 'functions.dart';
import 'user_secure_storage.dart';

class PageManager {

  // static final BehaviorSubject<LoginverificationResponse> loggedUser = BehaviorSubject();
  // static Stream<bool> saveLoggedUser(LoginverificationResponse loggedUser) {
  //
  //   return Stream.fromFuture(FileReadWrite.saveLoggedUser(loggedUser)).doOnError((e,st ) {
  //     debugPrint(e.toString());
  //     debugPrint(st.toString());
  //   });
  // }





//todo exac e
//   static Stream<Registration> register(String password, String confirmpassword, String email,) {
//     return Stream.fromFuture(
//             FunctionalPage.registration(password, confirmpassword, email))
//         .doOnError((e, st) {
//       debugPrint(e.toString());
//       debugPrint(st.toString());
//     });
//   }

  static Stream<Registration> register(String password, String confirmPassword, String email, String firstName, String lastName, BuildContext context) {
    return Stream.fromFuture(
        FunctionalPage.registration(password, confirmPassword, email, firstName,lastName, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  //todo exac e
  // static Stream<MyProfile> editMyProfile(String firstName, String lastName, String email, String image, List<dynamic> preference, BuildContext context) {
  //   return  Stream.fromFuture(
  //       FunctionalPage.editMyProfile(
  //           firstName, lastName, email, image,preference, context))
  //       .doOnError((e, st) {
  //     debugPrint(e.toString());
  //     debugPrint(st.toString());
  //   });
  // }
  static Stream<MyProfile> editMyProfile(String image, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.editMyProfile(
           image, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }


  static Stream<Verification> sendVerification(int user, String image,  BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.sendVerification(
            user, image, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<String> postFile(String file, String from) {
    return  Stream.fromFuture(
        FunctionalPage.postFile(
            file,from))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<String> postFileVerification(String file, String from, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.postFileVerification(
            file,from, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<DeleteRequest> deleteRequest(int id, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.deleteRequest(
            id,context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<DeleteRequest> deleteForum(int id, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.deleteForum(
            id,context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<MyProfile> editMyProfileNew(String firstName, String lastName, String email, String image, List<dynamic> preference, BuildContext context, bool from, int employment,bool employmentFrom) {
    return  Stream.fromFuture(
        FunctionalPage.editMyProfileNew(
            firstName, lastName, email, image,preference,context,from, employment, employmentFrom))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<MyProfile> editMyProfileSegment(List<dynamic> preference, BuildContext context, bool from, bool employmentFrom) {
    return  Stream.fromFuture(
        FunctionalPage.editMyProfileSegment(
            preference,context,from,  employmentFrom))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<MyProfile> editMyProfileEmployment(BuildContext context, bool from, int employment,bool employmentFrom) {
    return  Stream.fromFuture(
        FunctionalPage.editMyProfileEmployment(
            context, from, employment,employmentFrom))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }



//todo exac e
  Stream<LoginverificationResponse> login(String password, String email,BuildContext context) {
    return Stream.fromFuture(
        FunctionalPage().login(password, email,context))
        .doOnError((e, st) {

      debugPrint(e.toString());
      debugPrint(st.toString());

    });
  }

  static Stream<EmailRecover> emailRecover(String email,BuildContext context) {
    return Stream.fromFuture(
        FunctionalPage.emailREcover(email,context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<CheckEmailRecover> checkEmailRecover(String email, String confirmCode, BuildContext context) {
    return Stream.fromFuture(
        FunctionalPage.checkEmailREcover(email,confirmCode, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

//todo exac e
  static Stream<LoginverificationResponse> registerfinal(String password, String confirmpassword, String email, String confirmcode, String firstName, String lastName, BuildContext context) {
    // doOnData -> amen response stanaluc
    return Stream.fromFuture(
        FunctionalPage.registrationfinal(password, confirmpassword, email, confirmcode, firstName, lastName, context)).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }


//todo exac e
  static Stream<GetMe> getMe() {
    return Stream.fromFuture(FunctionalPage.getMe())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<GetUnseenRequest> getUnseenRequest() {
    return Stream.fromFuture(FunctionalPage.getUnseenRequest())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<SetUnseenRequest> setUnseenRequest(int id) {
    return Stream.fromFuture(FunctionalPage.setUnseenRequest(id))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }


  //todo exac e
  static Stream<SegmentList> getSegmentList() {
    return Stream.fromFuture(FunctionalPage.getSegmentList()).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<EmploymentList> getEmploymentList() {
    return Stream.fromFuture(FunctionalPage.getEmploymentList()).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }


//todo exac e
  static Stream<Feed> getFeeds() {
    return Stream.fromFuture(FunctionalPage.getFeeds()).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ForumTextAnswer> getTextAnswer(int id) {
    return Stream.fromFuture(FunctionalPage.getTextAnswer(id)).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<FeedDetails> getFeedDetail(int id) {
    return Stream.fromFuture(FunctionalPage.getFeedDetail(id)).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<ForumDetails> getForumDetail(int id) {
    return Stream.fromFuture(FunctionalPage.getForumDetail(id)).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<StaffUser> getStaffUser(int id) {
    return Stream.fromFuture(FunctionalPage.getStaffUser(id)).doOnError((e,st ) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  // static Stream<List<Feed>> getFeeds1(int id) {
  //   // print("tokeeeeeeeeeeennn");
  //   //print(json.decode(token));
  //   return Stream.fromFuture(FunctionalPage.getFeeds1(id)).doOnError((e,st ) {
  //     debugPrint(e.toString());
  //     debugPrint(st.toString());
  //   });
  // }

  //todo exac e
  static Stream<Forum> getForum() {
    return Stream.fromFuture(FunctionalPage.getForum())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  //todo exac e
  static Stream<GetRequest> getRequest() {
    return Stream.fromFuture(FunctionalPage.getRequest())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }







  static Stream<PostRequest> postRequest(int author,String title, String file, int staffrole, int userId,  String text ) {
    return  Stream.fromFuture(
        FunctionalPage.postRequest(author,title,file,staffrole, userId, text))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<PostToken> postToken(String token ) {
    return  Stream.fromFuture(
        FunctionalPage.postToken(token))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ForumTextAnswer> postForumTextAnswer(int forum,String text, int user, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.postForumTextAnswer(forum, text, user, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
  static Stream<ForumChoiseAnswer> postForumChoiceAnswer(int forum,int choice, int user, BuildContext context) {
    return  Stream.fromFuture(
        FunctionalPage.postForumChoiceAnswer(forum, choice, user, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<AddForum> postForum(String text, String file, String replyType, List forumChoices,  String endAt, int author, List segment ) {
    return  Stream.fromFuture(
        FunctionalPage.postForum(text, file, replyType, forumChoices, endAt, author,segment))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<AnswerRequest> postAnswerRequest(int id,String text ) {
    return  Stream.fromFuture(
        FunctionalPage.postAnswerRequest(id,text))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }


  static Stream<GetStaffRole> getStaffRole() {
    return Stream.fromFuture(FunctionalPage.getStaffRole())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
}
