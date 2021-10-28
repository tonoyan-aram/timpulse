import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static var _storage = FlutterSecureStorage();

  static const _keyUsername = 'token';
  static const _keyPushToken = 'pushToken';
  static const _keyUserid = 'id';
  static const _keyUserrole = 'role';
  static const _keyUserLoged = 'loged';
  static const _keyIsFirst = "true";
  static const _keyIsSegment = "segment";


  static Future setUsername(String token) async =>
      await _storage.write(key: _keyUsername, value: token);

  static Future setPushToken(String pushToken) async =>
      await _storage.write(key: _keyPushToken, value: pushToken);

  static Future setUserrole(String role) async =>
      await _storage.write(key: _keyUserrole, value: role);

  static Future setUserid(String id) async =>
      await _storage.write(key: _keyUserid, value: id);

  static Future setUserLoged(String loged) async =>
      await _storage.write(key: _keyUserLoged, value: loged);

  static Future setFirst(String seen) async =>
      await _storage.write(key: _keyIsFirst, value: seen);

  static Future setSegment(String segment) async =>
      await _storage.write(key: _keyIsSegment, value: segment);



  Future<String> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  Future<String> getPushToken() async {
    return await _storage.read(key: _keyPushToken);
  }
  Future<String> getSegment() async {
    return await _storage.read(key: _keyIsSegment);
  }

  Future<String> getUserrole() async {
    return await _storage.read(key: _keyUserrole);
  }

  Future<String> getUserid() async {
    return await _storage.read(key: _keyUserid);
  }

  Future<String> getUserLoged() async {
    return await _storage.read(key: _keyUserLoged);
  }
  Future<String> getFirst() async {
    return await _storage.read(key: _keyIsFirst);
  }


  static Future deletetall() async {
    await _storage.delete(key: _keyUsername);
    await _storage.delete(key: _keyIsSegment);
    await _storage.delete(key: _keyUserrole);
    await _storage.delete(key: _keyUserid);
    await _storage.delete(key: _keyUserLoged);
    await _storage.delete(key: _keyIsFirst);
  }




 //await _storage.deleteAll();
}