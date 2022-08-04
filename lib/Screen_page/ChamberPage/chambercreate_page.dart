// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';

class ChamberEditPage extends StatefulWidget {
  ChamberEditPage(educationex, {Key key}) : super(key: key);

  @override
  _ChamberEditPageState createState() => _ChamberEditPageState();
}

class _ChamberEditPageState extends StateMVC<ChamberEditPage> {
  FunctionController chmmberController = FunctionController();
  _ChamberEditPageState() : super(FunctionController());

  TextEditingController chamberNamecontroller = TextEditingController();
  TextEditingController chamberAddresscontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  File _regpic;
  final picker = ImagePicker();

  Future<File> file;
  _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _regpic = File(pickedFile.path);
    });
    // return _imageController.recievedPhoto(_regpic, context);
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
          Navigator.of(context).popAndPushNamed(RouteManeger.chambersetup_page),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'Add Chamber',
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
                Center(
                  child: _regpic == null
                      ? CircleAvatar(
                          radius: 70.r,
                          backgroundColor: Colors.white,
                          child: FlatButton(
                            child: Image.asset(
                              'assets/images/chambersetup.png',
                              //  height: 150,
                              // height: 193.h,
                              // width: 193.w,
                              fit: BoxFit.cover,
                            ),
                            onPressed: _getImage,
                          ),
                        )
                      : CircleAvatar(
                          radius: 70.r,
                          backgroundColor: Colors.white,

                          // decoration: BoxDecoration(shape: BoxShape.circle),
                          child: FlatButton(
                            child: Image.file(
                              _regpic,
                              fit: BoxFit.cover,
                              // height: 93.h,
                              // width: 93.w,
                            ),
                            onPressed: _getImage,
                          ),
                        ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                buildChamberName(chamberNamecontroller, context),
                SizedBox(
                  height: 5.h,
                ),
                buildChamberAddress(chamberAddresscontroller, context),
                SizedBox(
                  height: 5.h,
                ),
                buildDiscription(descriptioncontroller, context),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    height: 52.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (chamberNamecontroller.text == "") {
                          internaterror(" Filled can't be blank ", context);
                        } else if (chamberAddresscontroller.text == "") {
                          internaterror("Filled can't be blank ", context);
                        } else if (descriptioncontroller.text == "") {
                          internaterror("Filled can't be blank", context);
                        } else if (_regpic == null) {
                          internaterror("Image not selected ", context);
                        } else {
                          chmmberController.chambersetup(
                              chamberNamecontroller.text,
                              chamberAddresscontroller.text,
                              descriptioncontroller.text,
                              _regpic,
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff128041),
                      ),
                      child: Text(
                        ' Add to chamber list',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 15.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'No',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF1F5F8),
                        fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .popAndPushNamed(RouteManeger.chambersetup_page),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF2F5F7),
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ));
}

Widget buildChamberName(chamberAddresscontroller, context) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Chamber Name",
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
          // height: MediaQuery.of(context).size.height * 0.068,
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
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: TextFormField(
              controller: chamberAddresscontroller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Chamber Name',
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

Widget buildChamberAddress(chamberAddresscontroller, context) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Chamber Address",
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
          // height: MediaQuery.of(context).size.height * 0.068,
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
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: TextFormField(
              controller: chamberAddresscontroller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.phone,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'Chamber address',
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

Widget buildDiscription(descriptioncontroller, context) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Discription",
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
          // height: MediaQuery.of(context).size.height * 0.068,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffffffff), //E9F2F2
              borderRadius: BorderRadius.circular(10),
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
              controller: descriptioncontroller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.phone,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: 'we can help you',
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
