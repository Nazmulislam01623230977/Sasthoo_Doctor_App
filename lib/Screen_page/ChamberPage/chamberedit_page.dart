// ignore_for_file: deprecated_member_use

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
class ChamberPage extends StatefulWidget {
  var chamberdata;
  ChamberPage(this.chamberdata);

  @override
  _ChamberPageState createState() => _ChamberPageState(this.chamberdata);
}

class _ChamberPageState extends StateMVC<ChamberPage> {
  var chamberdata;
  FunctionController chmmberController = FunctionController();
  _ChamberPageState(this.chamberdata) : super(FunctionController());

  TextEditingController chamberNamecontroller = TextEditingController();
  TextEditingController chamberAddresscontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  String oldimage;
  File _regpic;
  final picker = ImagePicker();
  Future<File> file;
  _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _regpic = File(pickedFile.path);
    });
  }

  showdata() {
    oldimage = "${Baseurl.mainurl}" + "/${chamberdata['avater']}";
    chamberNamecontroller.text = "${chamberdata['chamber_name'].toString()}";
    chamberAddresscontroller.text = "${chamberdata['address'].toString()}";
    descriptioncontroller.text = "${chamberdata['description'].toString()}";
  }

  void initState() {
    super.initState();
    showdata();
    userdataget();
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(19.r),
                ),
              ),
              backgroundColor: Color(0xff128041),
              bottomOpacity: 0.0,
              elevation: 0.0,
              centerTitle: true,
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
                  onPressed: () {
                    // do something
                  },
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
              ]),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: _regpic == null
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70.r,
                          child: FlatButton(
                            child: Image.network(
                              oldimage.toString(),
                            ),
                            onPressed: _getImage,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70.r,
                          child: FlatButton(
                            child: Image.file(
                              _regpic,
                            ),
                            onPressed: _getImage,
                          ),
                        ),
                ),
                SizedBox(
                  height: 20.h,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                        } else {
                          chmmberController.chamberedit(
                              chamberNamecontroller.text,
                              chamberAddresscontroller.text,
                              descriptioncontroller.text,
                              _regpic,
                              chamberdata['id'].toString(),
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff128041),
                        textStyle: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 15.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                      child: Text(
                        ' Save',
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
}

Widget buildChamberName(chamberAddresscontroller, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
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
                ),
              ), //A7ADBC
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
                  )), //A7ADBC
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
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF000000),
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
                hintText: 'we help you',
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
