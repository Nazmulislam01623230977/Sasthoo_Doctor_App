import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: camel_case_types
class ForgetVerficationPhone_page extends StatefulWidget {
  ForgetVerficationPhone_page({Key key}) : super(key: key);

  @override
  ForgetVerficationPhone_pageState createState() =>
      ForgetVerficationPhone_pageState();
}

// ignore: camel_case_types
class ForgetVerficationPhone_pageState
    extends StateMVC<ForgetVerficationPhone_page> {
  LoginController forgetphone;
  ForgetVerficationPhone_pageState() : super(LoginController()) {
    forgetphone = controller as LoginController;
  }

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h, bottom: 26.h),
                  child: Center(
                    child: Text(
                      'Reset Password',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: Color(0xff128041),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Please enter your the phone number assosiated with account and we will send a verification code.',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                buildPhone(phoneController, context),

                SizedBox(
                  height: 15.h,
                ),
                // ignore: deprecated_member_use
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // <-- Radius
                      ),
                      primary: Color(0xff128041), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      if (phoneController.text.length != 11) {
                        _phonenumberToast(
                            "Phone number will be 11 digit", context);
                      } else {
                        forgetphone.phonesentotpforget(
                            phoneController.text, context);
                        print(phoneController);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Proceed',
                            style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
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

Widget buildPhone(phoneController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 14.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: GoogleFonts.poppins(
              color: Color(0xff00000),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400), //596970
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
              ],
              controller: phoneController,
              keyboardType: TextInputType.number,

              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '01XXXXXXXXX',
              ), //A7ADBC
            ),
          ),
        )
      ],
    ),
  );
}

void _phonenumberToast(String massge, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(massge),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
