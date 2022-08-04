import 'dart:io';

import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/speciality_model.dart';

class DoctorService {
  // ignore: missing_return
  static var msg;
  // ignore: missing_return
  Future<List<Speicality>> getdoctordata() async {
    var client = http.Client();
    try {
      await GetuserDataFromAPi.getuserdata();
      var mainurl =
          ApiRepo.speciallist + GetuserDataFromAPi.userdata['id'].toString();
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['result'];
        var jsondataencod = jsonEncode(jsondata);
        return speicalityFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }
}
