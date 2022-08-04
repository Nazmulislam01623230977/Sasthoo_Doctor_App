import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/onlineprofilesheduile.dart';
import '../model/profileShediule.dart';
import '../model/shedulelistmodel.dart';

class SheduleListService {
  static var msg;
  Future<List<SheduleList>> shedulelistfunction() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.shedulelist + userdata['id'].toString();
      var apiurl = Uri.parse(url);
      var response = await client.get(
        apiurl,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['result'];
        var jsondataencod = jsonEncode(jsondata);
        return sheduleListFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  Future<List<ProfilesheduleList>> profleshedulelistfunction() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.profileshedulelist + userdata['id'].toString();
      var apiurl = Uri.parse(url);
      var response = await client.get(
        apiurl,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        return profilesheduleListFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  Future<List<ProfileonlinesheduleList>>
      onlineprofleshedulelistfunction() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.onlineprofileshedulelist + userdata['id'].toString();
      var apiurl = Uri.parse(url);
      var response = await client.get(
        apiurl,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        // print(jsondataencod);
        return profileonlinesheduleListFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  // static shedulestatuschange(String id) async {
  //   var client = http.Client();
  //   try {
  //     await userdataget();
  //     var url = ApiRepo.shedulestatuschange + id;
  //     var apiurl = Uri.parse(url);
  //     var response = await client.get(
  //       apiurl,
  //       headers: headerValue,
  //     );
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       var jsonMap = jsonDecode(json);
  //       msg = jsonMap['status'];
  //     }
  //   } on Exception {
  //     return null;
  //   }
  // }

  static shedulestatuschange(String id) async {
    var client = http.Client();
    try {
      await userdataget();
      var mainurl = ApiRepo.shedulestatuschange + "$id";
      var url = Uri.parse(mainurl);
      var response = await client.get(
        url,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        print(jsonMap);
        msg = jsonMap['status'];
      }
    } on Exception {
      msg = null;
    }
  }
}
