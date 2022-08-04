import 'dart:convert';
import 'dart:io';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/profile.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/forgetotppage.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/apitoken.dart';
import '../repository/patientAppoinment_repository.dart';

class LoginController extends ControllerMVC {
  var token;
  var usergenid;
  var userdatashowdecode;
  _usergenid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    usergenid = sharedPreferences.getString('usergenid');
  }

  sendotp(String phone, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.phoneurl,
    );
    requestrespons.fields['phone'] = phone;
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['api_response_message'];
        if (msg == "SUCCESS") {
          sharedPreferences.setString("otpphone", '$phone');
          Navigator.of(context).popAndPushNamed(RouteManeger.otp_page);
        } else {
          internaterror("Something went wrong", context);
        }
      }

      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['result'];
        var msgpush = msg['phone'];
        internaterror(msgpush, context);
        Navigator.of(context).popAndPushNamed(RouteManeger.phnver_page);
      }
    });
  }

  otpVerify(String digitone, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phone = sharedPreferences.getString('otpphone');

    var otp = "$digitone";

    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.otpverify,
    );
    requestrespons.fields['phone'] = phone;
    requestrespons.fields['otp'] = otp;
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];

        if (msg == "success") {
          Navigator.of(context).popAndPushNamed(RouteManeger.regin_page);
        }
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == "error") {
          internaterror('Invalid Otp', context);
          Navigator.of(context).popAndPushNamed(RouteManeger.otp_page);
        }
      }
    });
  }

  loginverify(String phoneNum, String password, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.loginurl,
    );
    requestrespons.fields['phone'] = phoneNum;
    requestrespons.fields['password'] = password;
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        var result = data['result'];
        var usergenidd = result['user_gen_id'];
        var status = result['status'];
        var token = result['token'];
        sharedPreferences.setString('token', "$token");
        sharedPreferences.setString('usergenid', "$usergenidd");
        if (msg == "success") {
          sharedPreferences.setString('token', "$token");
          sharedPreferences.setString('approval_status', "$status");
          if (status == "panding") {
            Navigator.of(context)
                .popAndPushNamed(RouteManeger.uploadimage_page);
          } else if (status == "approved") {
            sharedPreferences.setString('userdata', jsonEncode(result));
            Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page);
          }
        }
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        var displaymsg = data['result'];
        if (msg == "error") {
          internaterror(displaymsg, context);
          Navigator.of(context).popAndPushNamed(RouteManeger.loginin_page);
        }
      }
    });
  }

  userdata(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _usergenid();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.userdata,
    );
    requestrespons.fields['user_gen_id'] = "$usergenid";
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var mas = data['status'];
        var userdata = data['result'];
        if (mas == "success") {
          sharedPreferences.setString('userdata', jsonEncode(userdata));
        }
      }
    });
  }

  recievedPhoto(File regiphoto, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.recievedPhoto,
    );
    requestrespons.fields['token'] = "$token";

    requestrespons.headers['Content-Type'] = "multipart/form-data";
    requestrespons.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        regiphoto.path,
      ),
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        var result = data['result'];
        var status = result['status'];
        var token = result['token'];
        if (msg == "success") {
          sharedPreferences.setString('token', "$token");
          sharedPreferences.setString('userdata', jsonEncode(result));
          sharedPreferences.setString('approval_status', "$status");
          if (status == "approved") {
            Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page);
          }
        }
      }

      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        var displaymsg = data['result'];
        print(displaymsg);
        if (msg == "error") {
          internaterror(displaymsg, context);
          Navigator.of(context).popAndPushNamed(RouteManeger.uploadimage_page);
        }
      }
    });
  }

  regVerify(
      String _tittleValue,
      firstname,
      lastname,
      emailcontroller,
      dateController,
      _genderValue,
      _bloodgroup,
      ncontroller,
      passport,
      bmdcnum,
      password,
      BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phone = sharedPreferences.getString('otpphone');
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.regverify,
    );

    requestrespons.fields['phone'] = phone;
    requestrespons.fields['title'] = _tittleValue;
    requestrespons.fields['first_name'] = firstname;
    requestrespons.fields['last_name'] = lastname;
    requestrespons.fields['email'] = emailcontroller;
    requestrespons.fields['date_of_birth'] = "$dateController";
    requestrespons.fields['gender'] = _genderValue;
    requestrespons.fields['blood_group'] = _bloodgroup;
    requestrespons.fields['nid'] = ncontroller;
    requestrespons.fields['passport'] = passport;
    requestrespons.fields['bmdc_no'] = bmdcnum;
    requestrespons.fields['password'] = password;
    requestrespons.fields['user_type'] = 'doctor';
    requestrespons.fields['roles'] = 'doctor';
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        var data = jsonDecode(massage);
        var msg = data['result'];
        print(msg);
        var usergenid = msg['user_gen_id'];
        var token = msg['token'];
        sharedPreferences.setString('token', "$token");
        sharedPreferences.setString('usergenid', "$usergenid");
        Navigator.of(context).popAndPushNamed(RouteManeger.uploadimage_page);
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == "error") {
          internaterror('Something went wrong ', context);
          Navigator.of(context).popAndPushNamed(RouteManeger.regin_page);
        }
      }

      if (res.statusCode == 301) {
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == 'error') {
          var result = data['result'];
          var msgphone = result['phone'];
          var msgemail = result['email'];
          print(result);
          if (msgphone != null) {
            internaterror(msgphone, context);
          }
          if (msgemail != null) {
            internaterror(msgemail, context);
          }
          Navigator.of(context).popAndPushNamed(RouteManeger.regin_page);
        }
      }
    });
  }

  workingexperience(
      String instituteController,
      designationController,
      departmentController,
      starttimeController,
      endtimeController,
      BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.workingexperence,
    );
    requestrespons.fields['institute_name'] = instituteController;
    requestrespons.fields['designation'] = designationController;
    requestrespons.fields['department'] = departmentController;
    requestrespons.fields['start_time'] = starttimeController;
    requestrespons.fields['end_time'] = endtimeController;
    requestrespons.fields['user_id'] = 'user_id';

    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        var data = jsonDecode(massage);
        var msg = data['result'];
        var token = msg['token'];

        sharedPreferences.setString('token', "$token");
        Navigator.of(context).popAndPushNamed(RouteManeger.uploadimage_page);
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];

        if (msg == "error") {
          internaterror('Something went wrong ', context);
          Navigator.of(context).popAndPushNamed(RouteManeger.regin_page);
        }
      }

      if (res.statusCode == 301) {
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == 'error') {
          var result = data['result'];
          var msgphone = result['phone'];
          var msgemail = result['email'];
          print(result);
          if (msgphone != null) {
            internaterror(msgphone, context);
          }
          if (msgemail != null) {
            internaterror(msgemail, context);
          }

          Navigator.of(context).popAndPushNamed(RouteManeger.regin_page);
        }
      }
    });
  }

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  logout(BuildContext context) async {
    cerculerShowDialog(context);
    await _getToken();
    if (token != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      internaterror("Logout successfull", context);
      Navigator.of(context).popAndPushNamed(RouteManeger.loginin_page);
    } else {
      internaterror("Already logout", context);
      Navigator.of(context).popAndPushNamed(RouteManeger.loginin_page);
    }
  }

  Future<bool> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Do you want to exit app?',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF040D13),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed: () => Navigator.pop(context, false),
                  color: Color(0xff128041),
                  child: Text(
                    'No',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF1F5F8),
                        fontWeight: FontWeight.bold),
                  )),
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed: () => exit(0),
                  color: Color(0xff128041),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF2F5F7),
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ));

  phonesentotpforget(String phone, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.forgetphonenum,
    );
    requestrespons.fields['phone'] = phone;
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['api_response_message'];
        if (msg == "SUCCESS") {
          sharedPreferences.setString("forgetphone", '$phone');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerficationOtpforget(phone)),
          );
        }
      }
      if (res.statusCode == 501) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['result'];
        print(msg);
        internaterror(msg, context);
        Navigator.of(context)
            .popAndPushNamed(RouteManeger.forgetpasswordpage_page);
      }
    });
  }

  forgetotpverfiy(String forgetotp, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var forgetphone = sharedPreferences.getString('forgetphone');
    print(forgetphone);

    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.forgetotpnum,
    );
    requestrespons.fields['phone'] = forgetphone.toString();
    requestrespons.fields['otp'] = forgetotp;
    requestrespons.send().then((res) async {
      print(res.statusCode);
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];

        if (msg == "success") {
          Navigator.of(context)
              .popAndPushNamed(RouteManeger.updatepassword_page);
        }
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == "error") {
          internaterror('Invalid Otp', context);
          Navigator.of(context).popAndPushNamed(RouteManeger.forgetotp_page);
        }
      }
    });
  }

  todaypatient() async {
    return PatientService.totdaypatientdata();
  }

  confirmpassword(String pass, conpass, BuildContext context) async {
    cerculerShowDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var forgetphone = sharedPreferences.getString('forgetphone');
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.changepassword,
    );
    requestrespons.fields['phone'] = forgetphone;
    requestrespons.fields['password'] = pass;
    requestrespons.send().then((res) async {
      print(res.statusCode);
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == "success") {
          print(msg);
          Navigator.of(context).popAndPushNamed(RouteManeger.loginin_page);
        }
      }
      if (res.statusCode == 401) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data['status'];
        if (msg == "error") {
          internaterror('Invalid Password', context);
          Navigator.of(context)
              .popAndPushNamed(RouteManeger.updatepassword_page);
        }
      }
    });
  }
}

void internaterror(String massge, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(massge),
      action: SnackBarAction(
          label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

cerculerShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        );
      });
}
