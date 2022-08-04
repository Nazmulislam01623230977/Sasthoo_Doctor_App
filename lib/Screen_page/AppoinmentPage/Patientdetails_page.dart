// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';
import '../../Controller/functionController.dart';
import '../../api/apiurl.dart';
import '../../model/appoinmentDetails.dart';

import '../../route/route.dart';
import '../../weiget/prescriptionDownload.dart';
import '../videocall_page.dart';

// ignore: must_be_immutable
class Patientdetails_page extends StatefulWidget {
  var id;
  Patientdetails_page(this.id, {Key key}) : super(key: key);

  @override
  _Patientdetails_pageState createState() => _Patientdetails_pageState(this.id);
}

class _Patientdetails_pageState extends State<Patientdetails_page> {
  // ignore: unused_field
  var id;
  _Patientdetails_pageState(this.id);
  String _genderValue;

  ProfileonlinesheduleList appoinmentdetails;
  var isLoaded = false;

  var imagepic;

  patientDeatilsfuncint() async {
    appoinmentdetails = await FunctionController().appoinmentDetails(id);
    if (appoinmentdetails != null) {
      setState(() {
        isLoaded = true;
        imagepic = appoinmentdetails.patienPhotos;
      });
    }
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

  void initState() {
    super.initState();
    patientDeatilsfuncint();
    this.userdataget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              'assets/images/noimage.png',
                            ),
                          )),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Text(
                'Patient Details',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              child: Divider(
                color: Colors.black,
                thickness: 1.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (appoinmentdetails != null)
                    imagepic != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60.r),
                            child: Image.network(
                              Baseurl.mainurl +
                                  "/" +
                                  appoinmentdetails.patienPhotos.avater,
                              height: 100.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60.r),
                            child: Image.asset(
                              "assets/images/noimage.png",
                              height: 100.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: appoinmentdetails != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appoinmentdetails.patient.firstName +
                                    " " +
                                    appoinmentdetails.patient.lastName,
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Reason: ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000)),
                                  ),
                                  Text(
                                    appoinmentdetails.problem,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 25.w,
                right: 20.w,
                bottom: 15.h,
              ),
              child: SizedBox(
                  width: 600.w,
                  child: appoinmentdetails != null
                      ? Text(
                          appoinmentdetails.problem,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: const Color(0xff3C3C3C),
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
            patientcard(appoinmentdetails),
            prescriptionDownload(
              icon: Icons.file_present_rounded,
              name: 'Previous Prescription.jpg',
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideocallingPage()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    primary: Color(0xff128041),
                    textStyle: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.bold)),
                child: Center(
                  child: Text(
                    "Start Consultant",
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget patientcard(appoinmentdetails) {
    var age;
    var payment;
    var blood;
    if (appoinmentdetails != null) {
      age = AgeCalculator.age(
        appoinmentdetails.patient.dateOfBirth,
      );

      payment = appoinmentdetails.paymentStatus;
      blood = appoinmentdetails.patient.bloodGroup;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffffffff), //E9F2F2
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Age : ',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(age.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  ),
                  // Row(
                  //   children: [Text('Weight :  '), Text('25')],
                  // ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Blood Group :',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              )),
                          appoinmentdetails != null
                              ? Text(blood)
                              : Text('',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment :',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              )),
                          appoinmentdetails != null
                              ? Text(payment)
                              : Text('',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget prescriptionDownload(
  //   IconData icon,
  //   String name,
  // ) {
  //   return Container(
  //     margin: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //         color: Color(0xffffffff), //E9F2F2
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black12,
  //             blurRadius: 6,
  //             offset: Offset(0, 2),
  //           )
  //         ]),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Icon(icon),
  //             Text(name),
  //             TextButton(onPressed: () {}, child: Text('(clict to download)'))
  //           ],
  //         ),
  //         Divider(
  //           color: Color(
  //             (0xffE5E5E5),
  //           ),
  //           thickness: .05,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
