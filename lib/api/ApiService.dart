import 'dart:convert';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/model/profile/workingexp_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class API_Manager {
  var userid;
  var userdatashow;
  var userdatashowdecode;
  var workingexp;
  var workingexpdata;

  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    userdatashowdecode = jsonDecode(userdatashow);
  }

  Future<List<WirkingExp>> workingexpfunction() async {
    await userdataget();
    userid = userdatashowdecode['id'];
    print(userid);
    var url = ApiRepo.workingexpurl + "${userid}";
    var apiurl = Uri.parse(url);
    print(url);
    try {
      var requestrespons = http.MultipartRequest(
        "GET",
        apiurl,
      );
      requestrespons.send().then((res) async {
        var massage = await res.stream.bytesToString();
        var jsonData = jsonDecode(massage);

        workingexpdata = (jsonData['result'] as List)
            .map((e) => WirkingExp.fromJSON(e))
            .toList();
      });
    } catch (Exception) {
      return workingexpdata;
    }

    return workingexpdata;
  }
}
