import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SheduleService {
  static String msg;
  static getdoctordata(String id) async {
    var client = http.Client();
    try {
      var mainurl = ApiRepo.schedulistdelete + id;
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
