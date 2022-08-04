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
class Stafflisteditpage extends StatefulWidget {
  var staffdata;
  Stafflisteditpage(this.staffdata);

  @override
  _StafflisteditpageState createState() =>
      _StafflisteditpageState(this.staffdata);
}

class _StafflisteditpageState extends StateMVC<Stafflisteditpage> {
  var staffdata;
  FunctionController staffeditController = FunctionController();
  _StafflisteditpageState(this.staffdata) : super(FunctionController());

  String _tittleValue;
  String _genderValue;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showstaffdata() {
    _tittleValue = "${staffdata['title'].toString()}";
    firstnameController.text = "${staffdata['first_name'].toString()}";
    lastnameController.text = "${staffdata['last_name'].toString()}";
    _genderValue = "${staffdata['gender'].toString()}";
    emailController.text = "${staffdata['email'].toString()}";
    phonenumController.text = "${staffdata['phone'].toString()}";
  }

  void initState() {
    super.initState();
    showstaffdata();
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
          Navigator.of(context).popAndPushNamed(RouteManeger.staff_page),
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
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: Text(
                      'Assistant Edit',
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 2.h, bottom: 2.h),
                    child: Divider(
                      color: Color(0xff000000),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
                    child: Text(
                      "Tittle",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ), //596970
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
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
                            horizontal: 8.w, vertical: 8.h),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: _tittleValue == null
                                ? Text(
                                    'Title',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    _tittleValue.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            isExpanded: true,
                            iconSize: 30.h,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                            items: [
                              'Mr',
                              'Mrs',
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
                  buildfirstname(firstnameController, context),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildlastname(lastnameController, context),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
                    child: Text(
                      "Gender",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ), //596970
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
                      child: Container(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: _genderValue == null
                                  ? Text(
                                      "Gender",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      _genderValue.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.h,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
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
                  buildemail(emailController, context),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildphone(phonenumController, context),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (firstnameController.text == "") {
                                internaterror(
                                    " Filled can't be blank ", context);
                              } else if (lastnameController.text == "") {
                                internaterror(
                                    "Filled can't be blank ", context);
                              } else if (emailController.text == "") {
                                internaterror("Filled can't be blank", context);
                              } else if (phonenumController.text.length != 11) {
                                internaterror("Filled can't be blank", context);
                              } else if (passwordController.text == null) {
                                internaterror(
                                    "Filled can't be blank ", context);
                              } else {
                                staffeditController.stafedit(
                                    _tittleValue,
                                    firstnameController.text,
                                    lastnameController.text,
                                    _genderValue,
                                    emailController.text,
                                    phonenumController.text,
                                    staffdata['id'].toString(),
                                    context);
                              }
                              // Navigator.of(context)
                              //     .popAndPushNamed(RouteManeger.staff_page);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff128041),
                                //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    //fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            child: Text(
                              'Save',
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

Widget buildfirstname(firstnameController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "First Name",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
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
              controller: firstnameController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.person,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'Nazmul islam',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildlastname(lastnameController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Last Name",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
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
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
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
                // prefixIcon: Icon(
                //   Icons.person,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'Islam',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildemail(emailController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.email,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'nazmulislam@gmail.com',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildphone(phonenumController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
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
              controller: phonenumController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.phone_android,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: '01xxxxxxxxxx',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildUserId(userIdController) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "User Id",
          style: TextStyle(
              color: Color(0xff596970),
              fontSize: 12,
              fontWeight: FontWeight.bold), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffE9F2F2), //E9F2F2
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userIdController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Color(0xffA7ADBC),
                  ),
                  hintText: '123',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildpassword(passwordController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
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
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.password,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: '........',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}
