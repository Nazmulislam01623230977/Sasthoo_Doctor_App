// ignore_for_file: unused_local_variable, unused_field
import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: camel_case_types
class Registration_page extends StatefulWidget {
  const Registration_page({Key key}) : super(key: key);

  @override
  _Registration_pageState createState() => _Registration_pageState();
}

// ignore: camel_case_types
class _Registration_pageState extends StateMVC<Registration_page> {
  final _emailkey = GlobalKey<FormState>();
  LoginController regfunction;
  _Registration_pageState() : super(LoginController()) {
    regfunction = controller as LoginController;
  }
  TextEditingController digitsoneController = TextEditingController();
  String _tittleValue;
  int age;
  bool _passwordVisible;
  String _genderValue;
  String _bloodgroup;
  DateTime _selectedDate;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passportcontroller = TextEditingController();
  TextEditingController bmdcnumcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController nidcontroller = TextEditingController();

  DateTime _currentdate = new DateTime.now();
  var initialDate = DateTime.now();
  String selectdate;
  var currentdate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialDate: _currentdate,
      firstDate: new DateTime(1970),
      lastDate: new DateTime(2030),
    );
    if (_seldate != null) {
      var day = _seldate.day;
      var month = _seldate.month;
      setState(() {
        _currentdate = _seldate;
        _selectedDate = _seldate;

        if (day < 10 && month < 10) {
          dateController.text =
              "${_seldate.year}-0${_seldate.month}-0${_seldate.day}";
        } else if (day < 10) {
          dateController.text =
              "${_seldate.year}-${_seldate.month}-0${_seldate.day}";
        } else if (month < 10) {
          dateController.text =
              "${_seldate.year}-0${_seldate.month}-${_seldate.day}";
        } else {
          dateController.text =
              "${_seldate.year}-${_seldate.month}-${_seldate.day}";
        }

        var selectdate = DateTime.parse(dateController.text);
        age = currentdate.year - selectdate.year;
      });
    }
  }

  int _value = 0;
  bool emailValid;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void regdatafunction() async {
    if (emailcontroller.text != "") {
      emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch((emailcontroller.text));
    }
    if (_tittleValue == null) {
      internaterror("Title can't be blank ", context);
    } else if (firstnamecontroller.text == "") {
      internaterror(" First Name can't be blank ", context);
    } else if (lastnamecontroller.text == "") {
      internaterror("Last Name can't be blank ", context);
    } else if (!emailValid) {
      internaterror("Email is invalid", context);
    } else if (dateController.text == "") {
      internaterror("Date of birth can't be blank", context);
    } else if (age <= 18) {
      internaterror(" Vendor must be 18 years old", context);
    } else if (_genderValue == null) {
      internaterror("Gender can't be blank", context);
    } else if (_bloodgroup == null) {
      internaterror("Blood Group can[t be blank", context);
    } else if (nidcontroller.text.length != 17 &&
        nidcontroller.text.length != 10) {
      internaterror("Nid number must be 10 or 17 digit  ", context);
    } else if (nidcontroller.text == "") {
      internaterror("Nid con't be blank  ", context);
    } else if (bmdcnumcontroller.text == "") {
      internaterror(" BMDC Filled can't be blank", context);
    } else if (bmdcnumcontroller.text.length != 6) {
      internaterror(" BMDC number must be 6 digit", context);
    } else if (passwordcontroller.text.length < 8) {
      internaterror("Password must be 8 digit", context);
    } else {
      regfunction.regVerify(
          _tittleValue,
          firstnamecontroller.text,
          lastnamecontroller.text,
          emailcontroller.text,
          dateController.text,
          _genderValue,
          _bloodgroup,
          nidcontroller.text,
          passportcontroller.text,
          bmdcnumcontroller.text,
          passwordcontroller.text,
          context);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.phnver_page),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // Select tittle dropdown
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 110.w, right: 121.w),
                  child: Text(
                    'Doctor Registration',
                    style: GoogleFonts.raleway(
                        color: Color(0xff128041),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 106.w, right: 105.w),
                  child: Text(
                    'All information must be valid and as per NID',
                    style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff989898)),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 106.w, right: 105.w),
                  child: Text(
                    '(All start mark must be required)',
                    style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFF3737)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: _tittleValue == null
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: Text(
                                  'Title*',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF323232),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: Text(
                                  _tittleValue,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF000000),
                                    // fontWeight: FontWeight.w600,
                                  ), //background: #3BE4C6;
                                ),
                              ),
                        isExpanded: true,
                        iconSize: 30.h,
                        // style: TextStyle(color: Colors.black),
                        items: [
                          'Dr.',
                          'Prof. Dr.',
                          'Assoc. Prof. Dr.',
                          'Asst. Prof. Dr.',
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

                // Divider(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: EdgeInsets.only(left: 8.w),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ), //back,
                        controller: firstnamecontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name*',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            // color: Color(0xFF312B2B),
                            fontWeight: FontWeight.w600,
                          ),

                          // labelText: 'First name*',
                          //border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        controller: lastnamecontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name*',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            // color: Color(0xFF2E2A2A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                    child: Form(
                      key: _emailkey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: TextFormField(
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF000000),
                            // fontWeight: FontWeight.w600,
                          ),
                          autofillHints: [AutofillHints.email],
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email*',
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF323232),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: EdgeInsets.only(left: 8.h),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        controller: dateController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'dd/mm/yyyy*',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF323232),
                            ),
                            // errorStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Color(0xff128041),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectDate(context);
                                  });
                                })),
                      ),
                    ),
                  ),
                ),

                //Selected Gender Dropdown
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: _genderValue == null
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  'Gender*',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF323232),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  _genderValue,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF000000),
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                        isExpanded: true,
                        iconSize: 30.h,
                        // style: GoogleFonts.poppins(color: Colors.black),
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
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: _bloodgroup == null
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  'Blood Group*',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF323232),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  _bloodgroup,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF000000),
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                        isExpanded: true,
                        iconSize: 30.h,
                        // style: TextStyle(color: Colors.black),
                        items: [
                          'AB ',
                          'AB-',
                          'A+',
                          'A-',
                          'B-',
                          'B+',
                          'O',
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
                              _bloodgroup = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: EdgeInsets.only(left: 8.w),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        controller: nidcontroller,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(17),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'NID Number*',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF323232),
                          ),

                          // border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: EdgeInsets.only(left: 8.w),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                        ],
                        controller: passportcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Passport ',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF323232),
                          ),

                          // border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
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
                      padding: EdgeInsets.only(left: 8.w),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        controller: bmdcnumcontroller,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'BMDC Registration Number*',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.068,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF), //E9F2F2
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(16),
                        ],
                        obscureText: !_passwordVisible,
                        controller: passwordcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off,
                              color: Color(0xffABABAB),
                              size: 15.h, //Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                this._passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          hintText: 'Password*',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF128041)),
                          value: _value,
                          groupValue: _value,
                          onChanged: (_value) {
                            if (_value == 0) {
                              setState(() {
                                _value = 1;
                              });
                            } else {
                              setState(() {
                                _value = 0;
                              });
                            }
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " I accept and agree ",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 9.sp),
                              ),
                              TextSpan(
                                text: "Terms and Condition",
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF0A3496),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: " and ",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 9.sp),
                              ),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF0A3496),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                // ignore: deprecated_member_use
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75.w),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(19.r), // <-- Radius
                        ),
                        primary: Color(0xff128041), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () => regdatafunction(),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8.h, bottom: 8.h, left: 75.w, right: 75.w),
                        child: Text(
                          'Registration',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Color(0xffffffff),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account? ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp,
                        color: Color(0xff000000),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.of(context)
                            .popAndPushNamed(RouteManeger.loginin_page);
                      }),
                      child: Text(
                        'SIGN IN',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: Color(0xffFF3737),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
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
}
