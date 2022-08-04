import 'package:doctot_sasthoo/model/emergencypatiend.dart';
import 'package:doctot_sasthoo/model/offlinepatient.dart';

import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/appoinmentDetails.dart';
import '../model/patient_details_model.dart';

class PatientService {
  static Future<List<PatientData>> getpatientdata() async {
    await userdataget();
    var client = http.Client();
    try {
      await gettoken();
      var mainurl = ApiRepo.appoinmentlist + userdata['id'].toString();
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);

        // print(jsondataencod);
        return patientDataFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  static Future<List<PatientData>> totdaypatientdata() async {
    await userdataget();
    var client = http.Client();
    try {
      await gettoken();
      var mainurl = ApiRepo.todayappoinment + userdata['id'].toString();
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);

        // print(jsondataencod);
        return patientDataFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  static Future<List<EmergencyPatientData>> emergencypatientdata() async {
    await userdataget();
    var client = http.Client();
    try {
      await gettoken();
      var mainurl = ApiRepo.emergencyappoinmentlist + userdata['id'].toString();
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        return emergencypatientDataFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  static Future<List<OfflinePatientData>> offlinepatientdata() async {
    await userdataget();
    var client = http.Client();
    try {
      await gettoken();
      var mainurl = ApiRepo.offlineappoinmentlist + userdata['id'].toString();
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        return offlinepatientDataFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  Future<ProfileonlinesheduleList> appoinmentDetails(String id) async {
    await userdataget();
    var client = http.Client();
    try {
      await gettoken();
      var mainurl = ApiRepo.appoinmentDetails + id;
      var url = Uri.parse(mainurl);
      var response = await client.get(url, headers: headerValue);
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        return profileonlinesheduleListFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }
}
