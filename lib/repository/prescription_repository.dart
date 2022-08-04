import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PrescriptionService {
  static String msg;
  static postprescription(Map prescription) async {
    var client = http.Client();
    try {
      var mainurl = ApiRepo.prescriptionsend;
      var url = Uri.parse(mainurl);
      var response = await client.post(
        url,
        body: prescription,
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
