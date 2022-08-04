// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';

// Education page add
class WorkingExperience extends StatefulWidget {
  WorkingExperience({Key key}) : super(key: key);

  @override
  _WorkingExperienceState createState() => _WorkingExperienceState();
}

class _WorkingExperienceState extends StateMVC<WorkingExperience> {
  FunctionController educationController = FunctionController();
  _WorkingExperienceState() : super(FunctionController());

  // ignore: non_constant_identifier_names
  String _Examination;
  TextEditingController instituteController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController scaleController = TextEditingController();

  File _uppic;
  final picker = ImagePicker();
  Future<File> file;
  _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _uppic = File(pickedFile.path);
    });
    // return _imageController.recievedPhoto(_uppic, context);
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
    this.userdataget();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.profile_page),
      child: Scaffold(
        appBar: AppBar(
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
                            Baseurl.mainurl + "/${photo['avater'].toString()}",
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
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //   image: new DecorationImage(
            //     image: AssetImage('assets/images/bg.png'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
                    child: Text(
                      "Examination",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Color(0xFF323232),
                        fontWeight: FontWeight.w600,
                      ), //596970
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
                    child: Container(
                      height: 52.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color(0xfffffffff), //E9F2F2
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
                            vertical: 8.h, horizontal: 8.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: _Examination == null
                                ? Text(
                                    'Examination',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w600,
                                    ), //
                                  )
                                : Text(
                                    _Examination,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            isExpanded: true,
                            iconSize: 30.h,
                            style: TextStyle(color: Colors.black),
                            items: ['MBBS', 'PHD', 'Dr'].map(
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
                                  _Examination = val;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildinstitute(instituteController),
                  SizedBox(
                    height: 5.h,
                  ),
                  builddepartment(departmentController),
                  SizedBox(
                    height: 5,
                  ),
                  passingyear(passingYearController),
                  SizedBox(
                    height: 5.h,
                  ),
                  grade(gradeController),
                  SizedBox(
                    height: 5.h,
                  ),
                  scale(scaleController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildexperience(_uppic, _getImage),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 52.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (instituteController.text == "") {
                            internaterror(" Filled can't be blank ", context);
                          } else if (departmentController.text == "") {
                            internaterror("Filled can't be blank ", context);
                          } else if (gradeController.text == "") {
                            internaterror("Filled can't be blank", context);
                          } else if (scaleController.text == "") {
                            internaterror("Filled can't be blank", context);
                          } else if (_uppic == null) {
                            internaterror("Image not selected ", context);
                          } else {
                            educationController.educationsetup(
                              _Examination,
                              instituteController.text,
                              departmentController.text,
                              passingYearController.text,
                              gradeController.text,
                              scaleController.text,
                              _uppic,
                              context,
                            );
                          }
                          // Navigator.of(context)
                          //     .popAndPushNamed(RouteManeger.profile_page);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            padding: EdgeInsets.all(8),
                            textStyle: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold)),
                        child: Text(
                          'save',
                          style: GoogleFonts.poppins(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
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

Widget buildinstitute(instituteController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Name of Institute",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ), // //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xfffffffff), //E9F2F2
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
              controller: instituteController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'medical name',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget builddepartment(departmentController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Department",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xfffffffff), //E9F2F2
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
              controller: departmentController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'department name',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget passingyear(passingYearController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Passing Year",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xfffffffff), //E9F2F2
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
              controller: passingYearController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.cast_for_education,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: '2015-2020',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  )), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget grade(gradeController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Grade",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xfffffffff), //E9F2F2
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
              controller: gradeController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.cast_for_education,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: '3.0 out 4',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  )), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget scale(scaleController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Scale",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xfffffffff), //E9F2F2
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
              controller: scaleController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '5 star',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  )), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildexperience(_uppic, _getImage) {
  var uppic = _uppic;
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Experience",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFF323232),
            fontWeight: FontWeight.w600,
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Center(
          child: uppic == null
              ? Container(
                  height: 100.h,
                  width: double.infinity,
                  child: FlatButton(
                    child: Image.asset('assets/images/upload.png'),
                    onPressed: _getImage,
                  ),
                )
              : Container(
                  height: 100.h,
                  width: double.infinity,
                  child: FlatButton(
                    child: Image.file(_uppic),
                    onPressed: _getImage,
                    // style: ElevatedButton.styleFrom(
                    //   primary: Color(0xffE9F2F2),
                    // ),
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
