import 'dart:convert';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';

// ignore: must_be_immutable
class GenarelInformation extends StatefulWidget {
  var genarelinformationdata;
  GenarelInformation(this.genarelinformationdata);

  @override
  _GenarelInformationState createState() =>
      _GenarelInformationState('genarelinformationdata');
}

class _GenarelInformationState extends StateMVC<GenarelInformation> {
  var genarelinformationdata;
  FunctionController genarelinformationController = FunctionController();
  _GenarelInformationState(this.genarelinformationdata)
      : super(FunctionController());
  var userdatashowdecode;
  var userdatashow;
  String _tittleValue;
  String _genderValue;
  bool get hasFocus => false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController bmdcController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  userdatashoww() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _tittleValue = sharedPreferences.getString('title');
    });
    userdatashow = sharedPreferences.getString('userdata');
    userdatashowdecode = jsonDecode(userdatashow);
    firstnameController.text = "${userdatashowdecode['first_name'].toString()}";
    lastnameController.text = "${userdatashowdecode['last_name'].toString()}";
    _genderValue = "${userdatashowdecode['gender'].toString()}";
    emailController.text = "${userdatashowdecode['email'].toString()}";
    nidController.text = "${userdatashowdecode['nid'].toString()}";
    passportController.text = "${userdatashowdecode['passport'].toString()}";
    bmdcController.text = "${userdatashowdecode['bmdc_no'].toString()}";
    phoneController.text = "${userdatashowdecode['phone'].toString()}";
    _tittleValue = "${userdatashowdecode['title'].toString()}";
    print(_tittleValue);
  }

  void initState() {
    super.initState();
    userdatashoww();
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
                      "Tittle",
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
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: _tittleValue == null
                                ? Text(
                                    'Title',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ) //
                                : Text(
                                    _tittleValue.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            isExpanded: true,
                            iconSize: 30.h,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Color(0xFF323232),
                              fontWeight: FontWeight.w600,
                            ),
                            items: ['Dr', 'MBS Dr', 'PSD Dr'].map(
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
                                  _tittleValue = val;
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
                  buildfullname(firstnameController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildlastname(lastnameController),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
                    child: Text(
                      "Gender",
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
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: _genderValue == null
                                  ? Text(
                                      "Gender",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Color(0xFF323232),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      _genderValue.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Color(0xFF323232),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.h,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w600,
                              ),
                              items: ['Male', 'Female', 'Others'].map(
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
                                    _genderValue = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildemail(emailController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildnid(nidController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildnidpassport(passportController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildbmdc(bmdcController),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildphone(phoneController),
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
                              if (firstnameController.text == "") {
                                internaterror(
                                    " Filled can't be blank ", context);
                              } else if (lastnameController.text == "") {
                                internaterror("Filled can't be blank", context);
                              } else if (emailController.text == "") {
                                internaterror("Filled can't be blank", context);
                              } else if (nidController.text == '') {
                                internaterror(
                                    "Filled can't be blank ", context);
                              } else if (passportController.text == '') {
                                internaterror(
                                    "Filled can't be blank ", context);
                              } else if (bmdcController.text == '') {
                                internaterror("Filled can't be blank", context);
                              } else if (phoneController.text == '') {
                                internaterror(
                                    "Filled can't be blank ", context);
                              } else {
                                genarelinformationController
                                    .genarelinformationedit(
                                        _tittleValue,
                                        firstnameController.text,
                                        lastnameController.text,
                                        _genderValue,
                                        emailController.text,
                                        phoneController.text,
                                        nidController.text,
                                        passportController.text,
                                        bmdcController.text,
                                        context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff128041),
                                padding: EdgeInsets.all(8),
                                textStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold)),
                            child: Text(
                              'save',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ))),
                  ),
                  SizedBox(
                    height: 25.sp,
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

Widget buildfullname(fullnameController) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "First Name",
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
              controller: fullnameController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'First Name',
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

Widget buildlastname(lastnameController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Last Name",
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
              controller: lastnameController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Last name',
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

Widget buildemail(emailController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Email",
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
              enableInteractiveSelection: false, // will disable paste operation
              focusNode: new AlwaysDisabledFocusNode(),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'examplem@gmail.com',
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

Widget buildnid(nidController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "NID Number",
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
              enableInteractiveSelection: false, // will disable paste operation
              focusNode:
                  new AlwaysDisabledFocusNode(), // will disable paste operation
              // focusNode:  AlwaysDisabledFocusNode(),
              controller: nidController,

              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '01XXXXXXXXX',
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

Widget buildnidpassport(passportController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "NID/Passport Number",
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
              enableInteractiveSelection: false, // will disable paste operation
              focusNode: new AlwaysDisabledFocusNode(),
              controller: passportController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.password_rounded,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: '0000000000',
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

Widget buildbmdc(bmdcController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "BMDC Number",
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
          height: 52.0,
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
              enableInteractiveSelection: false, // will disable paste operation
              focusNode: new AlwaysDisabledFocusNode(),
              controller: bmdcController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.format_list_numbered,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: '0000000000',
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

Widget buildphone(phoneController) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
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
              controller: phoneController,
              keyboardType: TextInputType.emailAddress,
              enableInteractiveSelection: false, // will disable paste operation
              focusNode: new AlwaysDisabledFocusNode(),
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '01XXXXXXXXX',
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
