import 'dart:convert';

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/model/doctor_free_list.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';

//  must_be_immutable
// ignore: camel_case_types
class FeesEdit_page extends StatefulWidget {
  var feeseditdata;
  FeesEdit_page(this.feeseditdata);

  @override
  _FeesEdit_pageState createState() => _FeesEdit_pageState(this.feeseditdata);
}

// ignore: camel_case_types
class _FeesEdit_pageState extends StateMVC<FeesEdit_page> {
  var feeseditdata;
  FunctionController staffeditController = FunctionController();
  _FeesEdit_pageState(this.feeseditdata) : super(FunctionController());

  String _schedule;
  var onlinestatus;
  List schedulelist = [];
  TextEditingController newpatientController = TextEditingController();
  TextEditingController oldpatientController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  showfeesdata() {
    this.setState(() {
      // _schedule = feeseditdata.day;
    });

    onlinestatus = feeseditdata.onlineStatus;
    newpatientController.text = feeseditdata.newPatientFree;
    oldpatientController.text = feeseditdata.oldPatientFree;
    reportController.text = feeseditdata.reportPatientFree;
  }

  void initState() {
    super.initState();
    showfeesdata();
    this.userdataget();
  }

  var photo;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
  }

  // _FeesEdit_pageState(feeseditdata);
  @override
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
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: Text(
                      'Fee Edit',
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.h, bottom: 2.h, left: 20.w, right: 10.w),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.h,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 20.w),
                  //   child: Text(
                  //     "Select your chamber",
                  //     style: GoogleFonts.poppins(
                  //         color: Color(0xff172331),
                  //         fontSize: 12.sp,
                  //         fontWeight: FontWeight.w500), //596970
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  //     child: Container(
                  //       height: 52.h,
                  //       alignment: Alignment.centerLeft,
                  //       decoration: BoxDecoration(
                  //           color: Color(0xffFFFFFF), //E9F2F2
                  //           borderRadius: BorderRadius.circular(10.r),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12,
                  //               blurRadius: 6,
                  //               offset: Offset(0, 2),
                  //             )
                  //           ]),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 8.w, vertical: 8.h),
                  //         child: DropdownButtonHideUnderline(
                  //           child: DropdownButton(
                  //             hint: _schedule == null
                  //                 ? Text(
                  //                     'Select your chamber',
                  //                     style: GoogleFonts.poppins(
                  //                         color: Color(0xff172331),
                  //                         fontSize: 12.sp,
                  //                         fontWeight: FontWeight.w500),
                  //                   )
                  //                 : Text(
                  //                     _schedule,
                  //                     style: GoogleFonts.poppins(
                  //                         color: Color(0xff172331),
                  //                         fontSize: 12,
                  //                         fontWeight: FontWeight.w500),
                  //                   ),
                  //             isExpanded: true,
                  //             iconSize: 30.h,
                  //             style: GoogleFonts.poppins(
                  //                 color: Color(0xff172331),
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w500),
                  //             items: schedulelist.map(
                  //               (val) {
                  //                 return DropdownMenuItem<String>(
                  //                     child: Text(val['day']),
                  //                     value: val['day']);
                  //               },
                  //             ).toList(),
                  //             onChanged: (val) {
                  //               setState(
                  //                 () {
                  //                   _schedule = val;
                  //                   // print(_schedule);
                  //                 },
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 20.w),
                  //   child: Text(
                  //     "Online Status",
                  //     style: GoogleFonts.poppins(
                  //         color: Color(0xff172331),
                  //         fontSize: 12.sp,
                  //         fontWeight: FontWeight.w500), //596970
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  //     child: Container(
                  //       height: 52.h,
                  //       alignment: Alignment.centerLeft,
                  //       decoration: BoxDecoration(
                  //           color: Color(0xffFFFFFF), //E9F2F2
                  //           borderRadius: BorderRadius.circular(10.r),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black12,
                  //               blurRadius: 6,
                  //               offset: Offset(0, 2),
                  //             )
                  //           ]),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 8.w, vertical: 8.h),
                  //         child: DropdownButtonHideUnderline(
                  //           child: DropdownButton(
                  //             hint: onlinestatus == null
                  //                 ? Text(
                  //                     'Select online status*',
                  //                     style: GoogleFonts.poppins(
                  //                         color: Color(0xff172331),
                  //                         fontSize: 12.sp,
                  //                         fontWeight: FontWeight.w500),
                  //                   )
                  //                 : Text(
                  //                     onlinestatus,
                  //                     style: GoogleFonts.poppins(
                  //                         color: Color(0xff172331),
                  //                         fontSize: 12.sp,
                  //                         fontWeight: FontWeight.w500),
                  //                   ),
                  //             isExpanded: true,
                  //             iconSize: 30.h,
                  //             style: GoogleFonts.poppins(
                  //                 color: Color(0xff172331),
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.w500),
                  //             items: [
                  //               'Online',
                  //               'Offline',
                  //             ].map(
                  //               (val) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: val,
                  //                   child: Text(val),
                  //                 );
                  //               },
                  //             ).toList(),
                  //             onChanged: (val) {
                  //               setState(
                  //                 () {
                  //                   onlinestatus = val;
                  //                 },
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
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
                            if (newpatientController.text == "") {
                              internaterror("Filled can't be blank", context);
                            } else if (oldpatientController.text == "") {
                              internaterror("Filled can't be blank", context);
                            } else if (reportController.text == "") {
                              internaterror("Filled can't be blank", context);
                            } else {
                              staffeditController.feesedit(
                                  newpatientController.text,
                                  oldpatientController.text,
                                  reportController.text,
                                  feeseditdata.id.toString(),
                                  context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff128041),
                              textStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500)),
                          child: Text('Save')),
                    ),
                  ),
                ],
              ),
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
              "Fee",
              style: GoogleFonts.poppins(
                  color: Color(0xff172331),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500), //596970
            ),
            Text(
              "(For new patient)",
              style: GoogleFonts.poppins(
                  color: Color(0xff172331),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w500), //596970
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
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
                  color: Color(0xff172331),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0.00tk',
                hintStyle: GoogleFonts.poppins(
                    color: Color.fromRGBO(23, 35, 49, 1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ), //A7ADBC
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
              "Fee ",
              style: GoogleFonts.poppins(
                  color: Color(0xff172331),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500), //596970
            ),
            Text(
              "(For old patient)",
              style: GoogleFonts.poppins(
                  color: Color(0xff172331),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w500), //596970
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
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
            padding:
                EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h, top: 8.h),
            child: TextFormField(
              controller: oldpatientController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                  color: Color(0xff172331),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0.00tk',
                hintStyle: GoogleFonts.poppins(
                    color: Color(0xff172331),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ), //A7ADBC
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
          "Report fees",
          style: GoogleFonts.poppins(
              color: Color(0xff172331),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
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
                  color: Color(0xff172331),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0.00tk',
                hintStyle: GoogleFonts.poppins(
                    color: Color(0xff172331),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ), //A7ADBC
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
