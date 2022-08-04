import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Controller/functionController.dart';
import '../../api/apitoken.dart';
import '../../route/route.dart';

// ignore: camel_case_types, must_be_immutable
class PrescriptionPdf_page extends StatefulWidget {
  var madicineData;
  var alltest;
  var problem;
  var firstName;
  var lastName;
  var id;
  var dateofbirth;
  PrescriptionPdf_page(this.madicineData, this.alltest, this.problem,
      this.firstName, this.lastName, this.id, this.dateofbirth,
      {Key key})
      : super(key: key);

  @override
  _PrescriptionPdf_pageState createState() => _PrescriptionPdf_pageState(
      this.madicineData,
      this.alltest,
      this.problem,
      this.firstName,
      this.lastName,
      this.id,
      this.dateofbirth);
}

// ignore: camel_case_types
class _PrescriptionPdf_pageState extends StateMVC<PrescriptionPdf_page> {
  var madicineData;
  var alltest;
  var problem;
  var firstName;
  var lastName;
  var id;
  var dateofbirth;

  DateTime dateTime = DateTime.now();

  FunctionController prescription;
  _PrescriptionPdf_pageState(this.madicineData, this.alltest, this.problem,
      this.firstName, this.lastName, this.id, this.dateofbirth)
      : super(FunctionController()) {
    prescription = controller as FunctionController;
  }

  prescriptionsend() async {
    await userdataget();
    Map prescriptiondata = {
      "madicine": jsonEncode(madicineData),
      "alltest": jsonEncode(alltest),
      "problem": problem,
      "user_id": id.toString(),
      "doctor_user_id": userdata['id'].toString(),
    };

    prescription.sendpresscription(prescriptiondata, context);
  }

  doctordata() async {
    await userdataget();
    setState(() {
      madicineData = madicineData;
    });
  }

  void initState() {
    super.initState();
    doctordata();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/pad.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, right: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 10.h,),
                            Text(
                              userdata['title'].toString() +
                                  " " +
                                  userdata['first_name'].toString() +
                                  " " +
                                  userdata['last_name'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xff128041),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Text(
                            //   // userdata.toString(),
                            //   "",
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 7,
                            //     color: Color(0xff000000),
                            //     fontWeight: FontWeight.w700,
                            //   ),
                            // ),
                            Text(
                              'International medical college',
                              style: GoogleFonts.poppins(
                                fontSize: 7.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'BMDC Reg no. A1452',
                              style: GoogleFonts.poppins(
                                fontSize: 7.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Dhanmondi Branch',
                              style: GoogleFonts.poppins(
                                fontSize: 7.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy – kk:mm').format(dateTime),
                              style: GoogleFonts.poppins(
                                fontSize: 7.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name :   ',
                              style: GoogleFonts.poppins(
                                fontSize: 8.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              firstName + " " + lastName,
                              style: GoogleFonts.poppins(
                                fontSize: 8.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Date of birth:',
                              style: GoogleFonts.poppins(
                                fontSize: 8.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              dateofbirth,
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Container(
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: Color(0xffEEEEEE), //E9F2F2
                          borderRadius: BorderRadius.circular(2.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ]),
                      child: Center(
                          child: Text(
                        'Medicine',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: Container(
                          height: 340.h,
                          decoration: BoxDecoration(
                              color: Color(0xffffffff), //E9F2F2
                              borderRadius: BorderRadius.circular(2.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                )
                              ]),
                          child: madicineData != null
                              ? ListView.builder(
                                  itemCount: madicineData.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                            title: Text(
                                              madicineData[index]
                                                      ['madicine_name']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            subtitle: Text("Per day " +
                                                madicineData[index]
                                                        ['madicine_perday']
                                                    .toString() +
                                                " " +
                                                madicineData[index]['pic']
                                                    .toString() +
                                                "||" +
                                                madicineData[index]
                                                        ['madicine_duration']
                                                    .toString() +
                                                " " +
                                                madicineData[index]['minite']
                                                    .toString() +
                                                "Total dorse " +
                                                madicineData[index]
                                                        ['total_dorse']
                                                    .toString() +
                                                " " +
                                                madicineData[index]['dayvalue']
                                                    .toString() +
                                                "||" +
                                                madicineData[index]
                                                        ['meal_value']
                                                    .toString() +
                                                " Meal")),
                                      ],
                                    );
                                  })
                              : Center(
                                  child: Text(
                                  'No madicine selected',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )))),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 120.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                              color: Color(0xffEEEEEE), //E9F2F2
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                )
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: Center(
                                child: ListView.builder(
                              itemCount: alltest.length,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var testselect = alltest[index];
                                return Text(testselect);
                              },
                            )),
                          ),
                        ),
                        Container(
                          height: 120.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: Color(0xffffffff), //E9F2F2
                              borderRadius: BorderRadius.circular(2.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                )
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              problem,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              ), //A7ADBC
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        onPressed: () {
                          prescriptionsend();
                        },
                        child: Text("Send")),
                  ),
                  SizedBox(
                    height: 110.h,
                  ),
                  Center(
                    child: Container(
                      height: 40.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ]),
                      child: Center(
                          child: Text(
                        'Helpline: 09782578',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
