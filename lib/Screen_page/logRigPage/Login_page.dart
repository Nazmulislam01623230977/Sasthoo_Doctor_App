// ignore_for_file: deprecated_member_use

import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: camel_case_types
class Login_Page extends StatefulWidget {
  const Login_Page({Key key}) : super(key: key);

  @override
  _Login_PageState createState() => _Login_PageState();
}

// ignore: camel_case_types
class _Login_PageState extends StateMVC<Login_Page> {
  bool isRememberme = false;
  bool _passwordVisible;

  LoginController loginfunction;
  _Login_PageState() : super(LoginController()) {
    loginfunction = controller as LoginController;
  }
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldpop = await loginfunction.showWarning(context);
        return shouldpop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  child: Column(children: [
                    SizedBox(
                      height: 41.h,
                    ),
                    Container(
                      child: Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 79.h,
                          width: 221.w,
                          // height: MediaQuery.of(context).size.height * .081.h,
                          // width: MediaQuery.of(context).size.width * .421.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 42.h,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/doctor.png",
                        height: 90.h,
                        width: 90.w,
                        // height: MediaQuery.of(context).size.height * .09.h,
                        // width: MediaQuery.of(context).size.width * .09.w,
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),

                    Text(
                      'Welcome',
                      style: GoogleFonts.poppins(
                        fontSize: 50.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    ), //26780D
                    Text(
                      'Sign in to continue.',
                      style: GoogleFonts.raleway(
                        fontSize: 15.sp,
                        color: Color(0xff128041),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    buildPhone(phoneNumController, context),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 11.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text(
                              "Password",
                              style: GoogleFonts.raleway(
                                  color: Color(0xff172331),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            height: 52.h,
                            // height: MediaQuery.of(context).size.height * 0.068,
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
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: !_passwordVisible,
                              // style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        left: 21.w,
                                        right: 48.w,
                                        top: 17.h,
                                        bottom: 17.h),
                                    child: Icon(
                                      Icons.lock_open,
                                      color: Color(0xff707070),
                                      size: 18.h,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _passwordVisible
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off,
                                        size: 15.h,
                                        color: Color(
                                            0xffABABAB) //Theme.of(context).primaryColorDark,
                                        ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: '........',
                                  hintStyle: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                      color: Color(0xffA7ADBC))),
                            ),
                          )
                        ],
                      ),
                    ),

                    buildForgotPass(context),

                    SizedBox(
                      height: 51.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 75.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(19.sp), // <-- Radius
                          ),
                          primary: Color(0xff128041), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (phoneNumController.text == "") {
                            internaterror(
                                "Phone number can't be empty ", context);
                          } else if (phoneNumController.text.length != 11) {
                            internaterror(
                                "Your phone number must be 11 digits ",
                                context);
                          }
                          if (passwordController.text == "") {
                            internaterror(
                                "password filed can't be blank ", context);
                          } else {
                            loginfunction.loginverify(phoneNumController.text,
                                passwordController.text, context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.h,
                            bottom: 8.h,
                          ),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 34.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .popAndPushNamed(RouteManeger.phnver_page);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account ?  ",
                              style: GoogleFonts.raleway(
                                color: Color(0xff0E0E0E),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: GoogleFonts.raleway(
                                color: Color(0xffFF0D0D),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildPhone(phoneNumController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            "Phone Number",
            style: GoogleFonts.raleway(
                color: Color(0xff172331),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600), //596970
          ),
        ),
        SizedBox(
          height: 6.h,
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
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
            ],
            controller: phoneNumController,
            keyboardType: TextInputType.number,
            // style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                      left: 21.w, top: 20.1.h, bottom: 20.1.h, right: 44.25.w),
                  child: Icon(
                    Icons.phone,
                    color: Color(0xff707070),
                    size: 12.h,
                  ),
                ),
                hintText: '01XXXXXXXXX',
                hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Color(0xff8C8FA5))), //A7ADBC
          ),
        )
      ],
    ),
  );
}

Widget buildForgotPass(BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(
        right: 30.w,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context)
              .popAndPushNamed(RouteManeger.forgetpasswordpage_page);
        },
        child: Text(
          'Forget Password?',
          style: GoogleFonts.poppins(
            color: Color(0xff128041),
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
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
