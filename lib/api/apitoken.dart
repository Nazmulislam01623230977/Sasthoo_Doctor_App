import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

var token;
gettoken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');
}

final headerValue = {
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};
var userdatashow;
var userdata;
userdataget() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userdatashow = sharedPreferences.getString('userdata');
  userdata = jsonDecode(userdatashow);
}

class GetuserDataFromAPi {
  static var userinfo;
  static var userdata;
  static getuserdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userinfo = sharedPreferences.getString('userdata');
    userdata = jsonDecode(userinfo);
  }
}
