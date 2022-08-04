import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';

import '../../Componet/MainDrawer.dart';
import '../../api/apitoken.dart';
import '../../repository/sheduleDelate_repository.dart';

// ignore: camel_case_types
class AddFess_page extends StatefulWidget {
  const AddFess_page({Key key}) : super(key: key);

  @override
  _AddFess_pageState createState() => _AddFess_pageState();
}

// ignore: camel_case_types
class _AddFess_pageState extends StateMVC<AddFess_page> {
  FunctionController sheduleController = FunctionController();
  _AddFess_pageState() : super(FunctionController());
  TextEditingController newpatientController = TextEditingController();
  TextEditingController oldpatientController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  List schedulelist = [];
  List chamberlist = [];
  String _chamber;
  List _myActivities1;
  String _myActivitiesResults;
  final formKey1 = new GlobalKey<FormState>();
  List _myActivities;
  var userdatashow;
  var userid;
  var _online_status;

  bool isvisible = false;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    userid = userdata['id'];
  }

// ==========================
  scheduilelistfunction() async {
    await userdataget();
    getdsheduledata(userid.toString(), _online_status);
  }

  getdsheduledata(String id, onlistatus) async {
    var client = http.Client();
    var mainurl = ApiRepo.schedulistforfree + id + "/" + "$onlistatus";
    try {
      var url = Uri.parse(mainurl);
      var response = await client.get(
        url,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        setState(() {
          schedulelist = jsonMap['result'];
        });
      }
    } on Exception {
      schedulelist = [];
    }
    if (onlistatus != "Online") {
      chamberlistfunction(id, onlistatus);
    } else {
      setState(() {
        chamberlist = [];
      });
    }
  }
// =====================

// ==========================
  chamberlistfunction(String id, _onlinestatus) async {
    await userdataget();
    var url = ApiRepo.chamberlist + "${userid}";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      if (_onlinestatus != "Online") {
        setState(() {
          chamberlist = jsonData['result'];
        });
      } else {
        setState(() {
          chamberlist = [];
        });
      }
    });
  }

// =====================
  gselectedchamber(String chmaber) async {
    await userdataget();

    var client = http.Client();
    var mainurl =
        ApiRepo.schedulistforfreechamber + userid.toString() + "/" + "$chmaber";
    try {
      var url = Uri.parse(mainurl);
      var response = await client.get(
        url,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        setState(() {
          schedulelist = jsonMap['result'];
        });
      }
    } on Exception {
      schedulelist = [];
    }
  }

// =====================
// =====================
  String _schedule;
  @override
  void initState() {
    super.initState();
    this.userdatagetdata();
    _myActivities = [];
    _myActivities1 = [];
  }

  _savesForm() {
    var form = formKey1.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResults = _myActivities1.toString();
      });
    }

    print(_myActivities);
  }

  var photo;
  userdatagetdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.feeslist_page),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(69.h),
          child: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset('assets/images/menu.png'));
            }),
            title: new Center(
                child: new Text('',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center)),
            centerTitle: true,
            backgroundColor: Color(0xff128041),
            bottomOpacity: 0.0,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Stack(
                  children: const [
                    Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    Positioned(
                      left: 10,
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 9,
                      ),
                    )
                  ],
                ),
                onPressed: () {},
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .popAndPushNamed(RouteManeger.profile_page);
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: photo != null
                        ? CircleAvatar(
                            radius: 18, // Image radius
                            backgroundImage: NetworkImage(
                              Baseurl.mainurl +
                                  "/${photo['avater'].toString()}",
                            ))
                        : const CircleAvatar(
                            radius: 18, // Image radius
                            backgroundImage: AssetImage(
                              'assets/fonts/images/noimage.png',
                            ),
                          )),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffFFFFFF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
                  child: Text(
                    'Fee Setup',
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 2.h, left: 20.w, right: 20.w),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "Online Status",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ), //596970
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                      height: 52.h,
                      // height: MediaQuery.of(context).size.height * 0.068,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: _online_status == null
                                ? Text(
                                    'Select online status*',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  )
                                : Text(
                                    _online_status,
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                            isExpanded: true,
                            iconSize: 30.h,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                            items: [
                              'Online',
                              'Offline',
                            ].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  this._online_status = val;
                                },
                              );
                              if (_online_status == "Online") {
                                setState(() {
                                  _chamber = "Online";
                                });
                                isvisible = false;
                              } else if (_online_status == "Offline") {
                                isvisible = true;
                              }
                              scheduilelistfunction();
                            },
                          ),
                        ),
                      ),
                    )),
                Visibility(
                  visible: isvisible,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      "Select chamber",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ), //596970
                    ),
                  ),
                ),
                Visibility(
                  visible: isvisible,
                  child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Container(
                        height: 52.h,
                        // height: MediaQuery.of(context).size.height * 0.068,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF), //E9F2F2
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: _chamber == null
                                  ? Text(
                                      'Select your chamber',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ), //596970
                                    )
                                  : Text(
                                      _chamber,
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ), //596970
                                    ),
                              isExpanded: true,
                              iconSize: 30.h,
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ), //596970
                              items: chamberlist.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                      child: Text(val['chamber_name']),
                                      value: val['chamber_name']);
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _chamber = val;

                                    print(_chamber);
                                  },
                                );
                                gselectedchamber(_chamber);
                              },
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.w, left: 16.w, right: 16.w, bottom: 2.h),
                  child: Form(
                    key: formKey1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      // padding: EdgeInsets.only(left: 8, top: 5, right: 8),
                      child: MultiSelectFormField(
                        border: InputBorder.none,
                        // autovalidate: false,
                        chipBackGroundColor: Colors.green,
                        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        checkBoxActiveColor: Colors.green,
                        checkBoxCheckColor: Color(0xffFFFFFF),
                        dialogShapeBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        title: Text(
                          "Select days",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ), //596970
                        ),
                        dataSource: schedulelist,
                        textField: 'day',
                        valueField: 'day',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',

                        initialValue: _myActivities,
                        onSaved: (value) {
                          if (value == null) return;
                          setState(() {
                            _myActivities = value;
                          });
                          print(_myActivities);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                buildNewPatient(newpatientController, context),
                SizedBox(
                  height: 5.h,
                ),
                buildOldPatient(oldpatientController, context),
                SizedBox(
                  height: 5.h,
                ),
                buildReport(reportController, context),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_online_status == null) {
                          internaterror(
                              "Online status name not selected yet!! ",
                              context);
                        } else if (newpatientController.text == "") {
                          internaterror("Filled can't be blank", context);
                        } else if (oldpatientController.text == "") {
                          internaterror("Filled can't be blank", context);
                        } else if (reportController.text == "") {
                          internaterror("Filled can't be blank", context);
                        } else {
                          sheduleController.feessetup(
                              jsonEncode(_myActivities),
                              _online_status,
                              newpatientController.text,
                              oldpatientController.text,
                              reportController.text,
                              _chamber,
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff128041),
                          textStyle: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w500)),
                      child: Text(' Save'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget buildNewPatient(newpatientController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Fee ",
              style: GoogleFonts.poppins(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ), //596970 //596970
            ),
            Text(
              "(For new patient)",
              style: GoogleFonts.poppins(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ), //596970 //596970
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
                controller: newpatientController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00tk',
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ) //596970)), //A7ADBC
                ),
          ),
        ),
      ],
    ),
  );
}

Widget buildOldPatient(oldpatientController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Fee",
              style: GoogleFonts.poppins(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ), //596970 //596970
            ),
            Text(
              "(For old patient)",
              style: GoogleFonts.poppins(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ), //596970 //596970
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            // padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: oldpatientController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00tk',
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ) //596970)), //A7ADBC
                ),
          ),
        ),
      ],
    ),
  );
}

Widget buildReport(reportController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Report",
          style: GoogleFonts.poppins(
            color: Color(0xFF000000),
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ), //596970 //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
                controller: reportController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00tk',
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ) //596970), //A7ADBC
                ),
          ),
        ),
      ],
    ),
  );
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
