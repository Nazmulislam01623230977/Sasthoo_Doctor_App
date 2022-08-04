// ignore_for_file: deprecated_member_use

import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:ourcourt/colorconstant.dart';
// import 'package:ourcourt/controller/loginandregistration_con.dart';

// ignore: must_be_immutable
class VerficationOtpforget extends StatefulWidget {
  var phone;
  VerficationOtpforget(this.phone);
  @override
  _VerficationOtpforgetState createState() =>
      _VerficationOtpforgetState(this.phone);
}

class _VerficationOtpforgetState extends StateMVC<VerficationOtpforget> {
  var phone;
  LoginController forgetotpnum;
  _VerficationOtpforgetState(this.phone) : super(LoginController()) {
    forgetotpnum = controller as LoginController;
  }
  TextEditingController otpforgetcontroller = TextEditingController();

  // _VerficationOtpforgetState(this.phone);
  var phoneno;
  getphonenumber() {
    setState(() {
      phoneno = phone;
    });

    print(phoneno);
  }

  void initState() {
    super.initState();
    lisienotp();
    getphonenumber();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 77.w,
                    ),
                    child: Text(
                      'Phone Number Verification',
                      style: GoogleFonts.raleway(
                        fontSize: 20.sp,
                        color: Color(0xff128041),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65.h,
                  ),
                  Image.asset(
                    "assets/images/otp.png",
                    height: 74.h,
                    width: 74.w,
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Text(
                    'Get Your Code',
                    style: GoogleFonts.poppins(
                      fontSize: 25.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Please enter the 4 digit code sent',
                    style: GoogleFonts.raleway(
                      fontSize: 15.sp,
                      color: Color(0xff128041),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'to your phone address.',
                    style: GoogleFonts.raleway(
                      fontSize: 15.sp,
                      color: Color(0xff128041),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 37.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
                    child: PinFieldAutoFill(
                      textInputAction: TextInputAction.done,
                      controller: otpforgetcontroller,
                      codeLength: 4,
                      onCodeChanged: (val) {
                        print('val');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'If you don’t receive code! ',
                            style: GoogleFonts.poppins(
                                color: Color(0xff172331),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp),
                          ),
                          TextSpan(
                            text: 'Resend',
                            style: GoogleFonts.poppins(
                              color: Color(0xff128041),
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19.r), // <-- Radius
                      ),
                      primary: Color(0xff128041), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      if (otpforgetcontroller.text.length == 4) {
                        forgetotpnum.forgetotpverfiy(
                            otpforgetcontroller.text, context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 108.w, right: 107.w, top: 8.h, bottom: 8.h),
                      child: Text(
                        'Proceed',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: Color.fromARGB(255, 255, 249, 249),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void lisienotp() async {
    // ignore: await_only_futures
    await SmsAutoFill().listenForCode;
  }
}
