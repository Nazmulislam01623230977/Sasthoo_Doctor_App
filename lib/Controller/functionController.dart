import 'package:doctot_sasthoo/Screen_page/ChamberPage/ChamberSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/FamillyPage/familylist.dart';
import 'package:doctot_sasthoo/Screen_page/FeesPage/FeeSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/profile.dart';
import 'package:doctot_sasthoo/Screen_page/Shedule/newschedulepage.dart';
import 'package:doctot_sasthoo/Screen_page/SpecialistPage/addspeciallistpage.dart';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/Stafflist_page.dart';
import 'package:doctot_sasthoo/Screen_page/WalletPage/Wallet_page.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../Screen_page/AppoinmentPage/AppoinmentList_page.dart';
import '../Screen_page/FeesPage/AddFees_page.dart';
import '../api/apitoken.dart';
import '../repository/freelist_repository.dart';
import '../repository/patientAppoinment_repository.dart';
import '../repository/prescription_repository.dart';
import '../repository/sheduleDelate_repository.dart';
import '../repository/shedulelist_repository.dart';
import '../repository/speciality_repositor.dart';
import '../repository/transaction_repository.dart';

class FunctionController extends ControllerMVC {
  var userdatashow;
  var userid;

  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    userid = userdata['id'];
  }

  sendpresscription(Map prescriptiondata, BuildContext context) {
    PrescriptionService.postprescription(prescriptiondata);
    String massage = PrescriptionService.msg;
    if (massage == "success") {
      internaterror("Prescription has been send successfull!! ", context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AppoinmentList_page()));
    } else {}
    internaterror("Something want wrong", context);
  }

  chambersetup(String cName, cAddress, description, File avater,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.chmbersetup,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['chamber_name'] = cName;
    requestrespons.fields['address'] = cAddress;
    requestrespons.fields['description'] = description;
    requestrespons.headers['Content-Type'] = "multipart/form-data";
    requestrespons.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        avater.path,
      ),
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Chamber added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.shecdulecreate_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.chamberedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.chamberedit_page);
      }
    });
  }

  chamberedit(String cName, cAddress, description, File avater, id,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.chmberedit,
    );

    shedulelist() async {
      return SheduleListService().shedulelistfunction();
    }

    requestrespons.fields['chamber_name'] = cName;
    requestrespons.fields['address'] = cAddress;
    requestrespons.fields['description'] = description;
    requestrespons.fields['id'] = "$id";
    if (avater != null) {
      requestrespons.headers['Content-Type'] = "multipart/form-data";
      requestrespons.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          avater.path,
        ),
      );
    }

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Chamber have been updated ", context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChamberSetup_page()));
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.chamberedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.chamberedit_page);
      }
    });
  }

  chamberdelete(String id, BuildContext context) {
    print(id);
    var url = ApiRepo.chamberdelete + "$id";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        internaterror("Chamber has been deleted", context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChamberSetup_page()));
      }
    });
  }

  educationsetup(String eexaminnation, einstitute, edepartment, epassingyear,
      egrade, escale, File avater, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.educationsave,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['examination'] = eexaminnation;
    requestrespons.fields['institute_name'] = einstitute;
    requestrespons.fields['department'] = edepartment;
    requestrespons.fields['passing_year'] = epassingyear;
    requestrespons.fields['grade'] = egrade;
    requestrespons.fields['scale'] = escale;
    requestrespons.files.add(
      await http.MultipartFile.fromPath(
        'experience_certificate',
        avater.path,
      ),
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("Education added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.working_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.working_page);
      }
    });
  }

  educationupdate(String eexaminnation, einstitute, epassingyear, egrade,
      escale, File avater, String id, BuildContext context) async {
    print(id);
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.educationupdate,
    );
    print(id);
    requestrespons.fields['id'] = "$id";
    requestrespons.fields['examination'] = eexaminnation;
    requestrespons.fields['institute_name'] = einstitute;
    requestrespons.fields['passing_year'] = epassingyear;
    requestrespons.fields['grade'] = egrade;
    requestrespons.fields['scale'] = escale;

    if (avater != null) {
      requestrespons.headers['Content-Type'] = "multipart/form-data";
      requestrespons.files.add(
        await http.MultipartFile.fromPath(
          'experience_certificate',
          avater.path,
        ),
      );
    }

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("Education Experince have been updated ", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        // Navigator.of(context).popAndPushNamed(RouteManeger.);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        // Navigator.of(context).popAndPushNamed(RouteManeger.);
      }
    });
  }

  educationexperincedelete(String id, BuildContext context) async {
    // print(id);
    await userdataget();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.educationdelete,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['id'] = "$id";
    requestrespons.send().then((res) async {
      // if (res.statusCode == 200) {
      var massage = await res.stream.bytesToString();
      var data = jsonDecode(massage);
      print(data);
      internaterror("Education experince has been deleted", context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
      // }
    });
  }

  workingsetup(String winstitute, wdegianation, wdepartment, wstarttime,
      wendtime, File avater, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.workingsave,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['institute_name'] = winstitute;
    requestrespons.fields['designation'] = wdegianation;
    requestrespons.fields['department'] = wdepartment;
    requestrespons.fields['start_time'] = wstarttime;
    requestrespons.fields['end_time'] = wendtime;
    requestrespons.files.add(
      await http.MultipartFile.fromPath(
        'experience_certificate',
        avater.path,
      ),
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("working Palce added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.education_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.education_page);
      }
    });
  }

  workingedit(String winstitute, wdegianation, wdepartment, wstarttime,
      wendtime, File avater, id, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.workingupdate,
    );
    requestrespons.fields['id'] = "$id";
    requestrespons.fields['institute_name'] = winstitute;
    requestrespons.fields['designation'] = wdegianation;
    requestrespons.fields['department'] = wdepartment;
    requestrespons.fields['start_time'] = wstarttime;
    requestrespons.fields['end_time'] = wendtime;

    if (avater != null) {
      requestrespons.headers['Content-Type'] = "multipart/form-data";
      requestrespons.files.add(
        await http.MultipartFile.fromPath(
          'experience_certificate',
          avater.path,
        ),
      );
    }

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Working Expereince have been updated ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.workingedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.workingedit_page);
      }
    });
  }

  workingexperincedelete(String id, BuildContext context) async {
    print(id);
    await userdataget();
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.workingdelete,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['id'] = "$id";
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Working experince has been deleted", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    });
  }

  genarelinformationedit(String gtitle, gfirstname, glastname, ggender, gemail,
      gphone, gnid, gpassport, gbmdc, BuildContext context) async {
    await userdataget();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.profileeditdata,
    );
    requestrespons.fields['user_id'] = userid.toString();
    requestrespons.fields['title'] = gtitle;
    requestrespons.fields['first_name'] = gfirstname;
    requestrespons.fields['last_name'] = glastname;
    requestrespons.fields['gender'] = ggender;
    requestrespons.fields['nid'] = gnid;
    requestrespons.fields['passport'] = gpassport;
    requestrespons.fields['bmdc_no'] = gbmdc;
    requestrespons.fields['email'] = gemail;
    requestrespons.fields['phone'] = gphone;
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        var result = data['result'];
        sharedPreferences.setString('userdata', jsonEncode(result));
        internaterror("Genarel Information have been updated ", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.genarel_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.genarel_page);
      }
    });
  }

  walletsetup(String accounttpe, bankname, accountname, accountnum, branchname,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.walletsetup,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['account_type'] = accounttpe;
    requestrespons.fields['account_name'] = accountname;
    requestrespons.fields['account_no'] = "$accountnum";
    requestrespons.fields['bank_name'] = bankname;
    requestrespons.fields['branch_name'] = branchname;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        // ignore: unused_local_variable
        var mas = data['status'];
        // ignore: unused_local_variable
        var accountdata = data['result'];
        internaterror("Wallet added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.wallet_page);
      }
      if (res.statusCode == 301) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        // var mas = data['status'];
        var accountdata = data['result'];
        var msg = accountdata['account_no'].toString();
        print(accountdata);
        internaterror(msg, context);
        Navigator.of(context).popAndPushNamed(RouteManeger.walletedit_page);
      }

      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.walletedit_page);
      }
    });
  }

  walletupdate(String accounttpe, bankname, accountname, accountnum, branchname,
      userid, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.walletedit,
    );
    requestrespons.fields['id'] = "$userid";
    requestrespons.fields['account_type'] = accounttpe;
    requestrespons.fields['bank_name'] = bankname;
    requestrespons.fields['account_name'] = accountname;
    requestrespons.fields['account_no'] = "$accountnum";
    requestrespons.fields['branch_name'] = branchname;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("Wallet have been updated ", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Wallet_page()));
      }
      if (res.statusCode == 301) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        // internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.walletedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.walletedit_page);
      }
    });
  }

  walletdelete(String id, BuildContext context) async {
    print(id);
    var url = ApiRepo.walletdelete + id;
    var apiurl = Uri.parse(url);
    print(apiurl);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("wallet has been deleted", context);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Wallet_page()));
      }
    });
  }

  stafsave(String stittle, sfirstname, slastname, sgender, semail, sphone,
      spassword, BuildContext context) async {
    //suserid,
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.staffsetup,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['title'] = stittle;
    requestrespons.fields['first_name'] = sfirstname;
    requestrespons.fields['last_name'] = slastname;
    requestrespons.fields['gender'] = sgender;
    requestrespons.fields['email'] = semail;
    requestrespons.fields['phone'] = sphone;
    requestrespons.fields['password'] = spassword;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        var mas = data['status'];
        internaterror("Staff added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.staff_page);
      }
      if (res.statusCode == 301) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror('filled in the blank', context);
        Navigator.of(context).popAndPushNamed(RouteManeger.staffsetup_page);
      }

      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.staffsetup_page);
      }
    });
  }

  stafedit(String stittle, sfirstname, slastname, sgender, semail, sphone, id,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.stafedit,
    );

    requestrespons.fields['id'] = "$id";
    requestrespons.fields['title'] = stittle;
    requestrespons.fields['first_name'] = sfirstname;
    requestrespons.fields['last_name'] = slastname;
    requestrespons.fields['gender'] = sgender;
    requestrespons.fields['email'] = semail;
    requestrespons.fields['phone'] = sphone;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Staff data have been updated ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.staff_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.stafflistedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.stafflistedit_page);
      }
    });
  }

  staffdelete(String id, BuildContext context) {
    print(id);
    var url = ApiRepo.staffdelete + "$id";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        internaterror("Staff list has been deleted", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Stafflist_page()));
      }
    });
  }

  feessetup(String shedule, onlinestatus, newpatient, oldpatient, reportpatient,
      _chamber, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    print(_chamber);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.doctorfeesetup,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['schedul_name'] = shedule;
    requestrespons.fields['online_status'] = onlinestatus;
    requestrespons.fields['new_patient_free'] = "$newpatient";
    requestrespons.fields['old_patient_free'] = "$oldpatient";
    requestrespons.fields['report_patient_free'] = "$reportpatient";

    requestrespons.fields['chamber_name'] = _chamber;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("Fees have been created successfull ", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeeSetup_page()));
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
      }
    });
  }

  feesedit(String newpatient, oldpatient, reportpatient, id,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.doctorfreeeidt,
    );

    requestrespons.fields['id'] = id;
    requestrespons.fields['new_patient_free'] = newpatient;
    requestrespons.fields['old_patient_free'] = oldpatient;
    requestrespons.fields['report_patient_free'] = reportpatient;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Fees  have been updated ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.feeslist_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.feesedit_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.feesedit_page);
      }
    });
  }

  feesdelete(String id, BuildContext context) {
    print(id);
    var url = ApiRepo.feesdelete + "$id";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        internaterror("Frees has been deleted", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeeSetup_page()));
      }
    });
  }

  familysetup(String id, relatin, BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.familysetup,
    );
    requestrespons.fields['doctor_user_id'] = "$userid";
    requestrespons.fields['patient_id'] = "$id";
    requestrespons.fields['relation'] = "$relatin";

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        internaterror("Family member added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.familysearch_page);
      }
      if (res.statusCode == 301) {
        internaterror("Already added member", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.familysearch_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.familysearch_page);
      }
    });
  }

  familylistdelete(String id, BuildContext context) {
    print(id);
    var url = ApiRepo.familydelete + "$id";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        internaterror("Familly member has been deleted", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.familysearch_page);
      }
    });
  }

  shedulesetup(
      String chamber,
      intervaltime,
      patientlimi,
      sunday,
      sunstarttime,
      sunendtime,
      monday,
      monstarttime,
      monendtime,
      tuesday,
      tuesstarttime,
      tuesendtime,
      wednesday,
      wednesstarttime,
      wednesendtime,
      thursday,
      thursstarttime,
      thursendtime,
      friday,
      fristarttime,
      friendtime,
      saturday,
      saturstarttime,
      saturendtime,
      onlinestatus,
      BuildContext context) async {
    await userdataget();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.schedulesetup,
    );

    print(chamber);
    requestrespons.fields['user_id'] = "$userid";

    if (onlinestatus == "Online") {
      requestrespons.fields['chamber_name'] = "offline";
    } else {
      requestrespons.fields['chamber_name'] = chamber;
    }

    requestrespons.fields['patient_limit'] = patientlimi;
    requestrespons.fields['interval_time'] = intervaltime;
    requestrespons.fields['onlinestatus'] = onlinestatus;

    if (sunday) {
      if (sunstarttime != null && sunendtime != null) {
        requestrespons.fields['sunday'] = "$sunday".toUpperCase();
        requestrespons.fields['sunstarttime'] = sunstarttime;
        requestrespons.fields['sunendtime'] = sunendtime;
      } else {
        internaterror(
            "Sunday start & end time not will be blank ".toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (monday) {
      if (monstarttime != null && monendtime != null) {
        requestrespons.fields['monday'] = "$monday".toUpperCase();
        requestrespons.fields['monstarttime'] = monstarttime;
        requestrespons.fields['monendtime'] = monendtime;
      } else {
        internaterror(
            "Monday start & end time not will be blank ".toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (tuesday) {
      if (tuesstarttime != null && tuesstarttime != null) {
        requestrespons.fields['tuesday'] = "$tuesday".toUpperCase();
        requestrespons.fields['tuesstarttime'] = tuesstarttime;
        requestrespons.fields['tuesendtime'] = tuesstarttime;
      } else {
        internaterror(
            "Tuesday start & end time not will be blank ".toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (wednesday) {
      if (wednesstarttime != null && wednesendtime != null) {
        requestrespons.fields['wednesday'] = "$wednesday".toUpperCase();
        requestrespons.fields['wednesstarttime'] = wednesstarttime;
        requestrespons.fields['wednesendtime'] = wednesendtime;
      } else {
        internaterror(
            "Wednesday start & end time not will be blank ".toString(),
            context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (thursday) {
      if (thursstarttime != null && thursendtime != null) {
        requestrespons.fields['thursday'] = "$thursday".toUpperCase();
        requestrespons.fields['thursstarttime'] = thursstarttime;
        requestrespons.fields['thursendtime'] = thursendtime;
      } else {
        internaterror(
            "Wednesday start & end time not will be blank ".toString(),
            context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (friday) {
      if (fristarttime != null && friendtime != null) {
        requestrespons.fields['friday'] = "$friday".toUpperCase();
        requestrespons.fields['fristarttime'] = fristarttime;
        requestrespons.fields['friendtime'] = friendtime;
      } else {
        internaterror(
            "Friday start & end time not will be blank ".toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    if (saturday) {
      if (saturstarttime != null && saturendtime != null) {
        requestrespons.fields['saturday'] = "$saturday".toUpperCase();
        requestrespons.fields['saturstarttime'] = saturstarttime;
        requestrespons.fields['saturendtime'] = saturendtime;
      } else {
        internaterror(
            "Friday start & end time not will be blank ".toString(), context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    }

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        print(data);
        internaterror("Shedule have been create successfully!! ", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddFess_page()));
      }
      // if (res.statusCode == 301) {
      //   var massage = await res.stream.bytesToString();
      //   var data = jsonDecode(massage);
      //   var msg = data["result"];
      //   internaterror(msg.toString(), context);
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => NewSchedulePage()));
      // }
      // if (res.statusCode == 501) {
      //   var massage = await res.stream.bytesToString();
      //   var data = jsonDecode(massage);
      //   var msg = data["result"];
      //   internaterror(msg.toString(), context);
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => NewSchedulePage()));
      // }
      if (res.statusCode == 401) {
        internaterror("Somethine went wrong", context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()));
      }
    });
  }

  speciallistsave(
      String sspeciaest, ssubspeciaest, BuildContext context) async {
    await userdataget();
    var speciestinputdata = jsonEncode(ssubspeciaest);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cerculerShowDialog(context);
    var requestrespons = http.MultipartRequest(
      "POST",
      ApiRepo.specialtsave,
    );
    requestrespons.fields['user_id'] = "$userid";
    requestrespons.fields['specialitie'] = sspeciaest;
    requestrespons.fields['sub_specialitie'] = speciestinputdata;

    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data["result"];
        print(msg);
        internaterror("Spicelist list  added successfully ", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
      }
      if (res.statusCode == 301) {
        internaterror("Filled can't be blank", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.specialist_page);
      }
      if (res.statusCode == 401) {
        internaterror("Something went wrong", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.specialist_page);
      }
    });
  }

  spiceistdelete(String id, BuildContext context) {
    print(id);
    var url = ApiRepo.specialistdelete + "$id";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        internaterror("Speciallist has been deleted", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    });
  }

  sheduleDelate(String id, proflie, BuildContext context) {
    SheduleService.getdoctordata(id);
    String msg = SheduleService.msg;

    if (msg == "success") {
      if (proflie != 'proflie') {
        internaterror("Shedule has been deleted successfully", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
      } else {
        internaterror("Shedule has been deleted successfully", context);
        Navigator.of(context).popAndPushNamed(RouteManeger.shecduleshow_page);
      }
    } else {
      internaterror("Something went wrong !!", context);
      Navigator.of(context).popAndPushNamed(RouteManeger.shecduleshow_page);
    }
  }

  patientDetatilsCont() async {
    return PatientService.getpatientdata();
  }

  sheduleactivestatus(String id, BuildContext context) async {
    await SheduleListService.shedulestatuschange(id);
    String msg = SheduleListService.msg;

    if (msg == "success") {
      internaterror("Your activate status has been updated!!", context);
      Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
    } else {
      internaterror("Something went wrong !!", context);
      Navigator.of(context).popAndPushNamed(RouteManeger.profile_page);
    }
  }

  emergencypatientDetatilsCont() async {
    return PatientService.emergencypatientdata();
  }

  offlinepatientDetatilsCont() async {
    return PatientService.offlinepatientdata();
  }

  shedulelist() async {
    return SheduleListService().shedulelistfunction();
  }

  profleshedulelist() async {
    return SheduleListService().profleshedulelistfunction();
  }

  onlineprofleshedulelist() async {
    return SheduleListService().onlineprofleshedulelistfunction();
  }

  appoinmentDetails(String id) async {
    return PatientService().appoinmentDetails(id);
  }

  transaction() async {
    return TransactionListService().transactionrepository();
  }

  doctorfree() async {
    return DoctorFreeListService().doctorfreerepository();
  }

  offlinedoctorfree() async {
    return DoctorFreeListService().doctorofffreerepository();
  }

  totalamountfunction() async {
    return TransactionListService().totalamount();
  }

  imagereuest(profilepic, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await GetuserDataFromAPi.getuserdata();

    // print(profilepic.path);
    var request = http.MultipartRequest(
      "POST",
      ApiRepo.uphotoupload,
    );
    request.fields['user_id'] = GetuserDataFromAPi.userdata['id'].toString();
    request.headers['Content-Type'] = "multipart/form-data";
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        profilepic.path,
      ),
    );
    request.send().then((res) async {
      if (res.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var mas = data['status'];
        var userdata = data['result'];
        if (mas == "success") {
          sharedPreferences.setString('userdata', jsonEncode(userdata));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        }
      }
    }).catchError((e) {});
  }

  specialitylist() async {
    return await DoctorService().getdoctordata();
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
