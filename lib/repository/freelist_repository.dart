import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/doctorOfflinefree.dart';
import '../model/doctor_free_list.dart';
import '../model/onlineprofilesheduile.dart';
import '../model/transaction_models.dart';

class DoctorFreeListService {
  Future<List<DoctorFree>> doctorfreerepository() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.doctorfree + userdata['id'].toString();
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
        return doctorFreeFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  Future<List<OffilleDoctorFree>> doctorofffreerepository() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.doctorofflinefree + userdata['id'].toString();
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
        return offilleDoctorFreeFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }
}
