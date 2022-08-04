import 'dart:convert';

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';

// ignore: must_be_immutable
class WorkingexperinseEdit extends StatefulWidget {
  var workingdata;
  WorkingexperinseEdit(this.workingdata);

  @override
  _WorkingexperinseEditState createState() =>
      _WorkingexperinseEditState(this.workingdata);
}

class _WorkingexperinseEditState extends StateMVC<WorkingexperinseEdit> {
  var workingdata;
  FunctionController workingeditController = FunctionController();
  _WorkingexperinseEditState(this.workingdata) : super(FunctionController());

  String workingimage;
  File _setpic;
  final picker = ImagePicker();
  Future<File> file;
  _getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _setpic = File(pickedFile.path);
    });
  }

  workingeditdata() {
    workingimage =
        "${Baseurl.mainurl}" + "/${workingdata['experience_certificate']}";
    instituteController.text = "${workingdata['institute_name'].toString()}";
    designationController.text = "${workingdata['designation'].toString()}";
    departmentController.text = "${workingdata['department'].toString()}";
    starttimeController.text = "${workingdata['start_time'].toString()}";
    endtimeController.text = "${workingdata['end_time'].toString()}";

    print(workingimage);
  }

  void initState() {
    super.initState();
    workingeditdata();
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

  TextEditingController instituteController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
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
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
              child: Column(
                children: [
                  buildinstitute(instituteController),
                  SizedBox(
                    height: 5.h,
                  ),
                  builddesignation(designationController),
                  SizedBox(
                    height: 5.h,
                  ),
                  builddepartment(departmentController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildstarttime(starttimeController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildendtime(endtimeController),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
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
                          child: _setpic == null
                              ? FlatButton(
                                  child: Image.network(
                                    workingimage.toString(),
                                    height: 120.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: _getImage,
                                )
                              : FlatButton(
                                  child: Image.file(
                                    _setpic,
                                    height: 120.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: _getImage,
                                ),
                        ),
                      ],
                    ),
                  ),
                  // buildexperience(_setpic, _getImage, workingimage),
                  SizedBox(
                    height: 20.h,
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
                          } else if (designationController.text == "") {
                            internaterror("Filled can't be blank ", context);
                          } else if (departmentController.text == "") {
                            internaterror("Filled can't be blank", context);
                          } else if (starttimeController.text == "") {
                            internaterror("Filled can't be blank", context);
                          } else if (endtimeController.text == "") {
                            internaterror("Filled can't be blank", context);
                          } else {
                            workingeditController.workingedit(
                                instituteController.text,
                                designationController.text,
                                departmentController.text,
                                starttimeController.text,
                                endtimeController.text,
                                _setpic,
                                workingdata['id'].toString(),
                                context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            padding: EdgeInsets.all(8),
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
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
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
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
                // prefixIcon: Icon(
                //   Icons.cast_for_education,
                //   color: Color(0xffA7ADBC),
                // ),
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

Widget builddesignation(designationController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Designation",
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
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
            child: TextFormField(
              controller: designationController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.description,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'designation',
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
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
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
                hintText: 'department',
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

Widget buildstarttime(starttimeController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Strat Time",
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
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
              controller: starttimeController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.time_to_leave,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: '2018',
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

Widget buildendtime(endtimeController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "End time",
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
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
              controller: endtimeController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.time_to_leave,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: '2022',
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

// Widget buildexperience(_setpic, _getImage, workingimage) {
//   String workingimage;
//   var _setpic;
//   return Padding(
//     padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           "Experience",
//           style: GoogleFonts.poppins(
//             fontSize: 12.sp,
//             color: Color(0xFF323232),
//             fontWeight: FontWeight.w600,
//           ), //596970
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         Center(
//           child: _setpic == null
//               ? ElevatedButton(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Color(0xffffffff), //E9F2F2
//                         borderRadius: BorderRadius.circular(10.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                             offset: Offset(0, 2),
//                           )
//                         ]),
//                     child: Image.network(workingimage.toString()),
//                     height: 100.h,
//                     width: 100.w,
//                   ),
//                   onPressed: _getImage,
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xffE9F2F2),
//                   ))
//               : ElevatedButton(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Color(0xffE9F2F2), //E9F2F2
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                             offset: Offset(0, 2),
//                           )
//                         ]),
//                     child: Image.file(_setpic),
//                     height: 100.h,
//                     width: 100.w,
//                   ),
//                   onPressed: _getImage,
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xffE9F2F2),
//                   ),
//                 ),
//         ),
//       ],
//     ),
//   );
// }
