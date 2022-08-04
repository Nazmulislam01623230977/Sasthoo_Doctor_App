// ignore_for_file: deprecated_member_use
import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sms_autofill/sms_autofill.dart';

// ignore: camel_case_types
class Verification_otp extends StatefulWidget {
  const Verification_otp({Key key}) : super(key: key);

  @override
  _Verification_otpState createState() => _Verification_otpState();
}

// ignore: camel_case_types
class _Verification_otpState extends StateMVC<Verification_otp> {
  LoginController otpfunction;
  _Verification_otpState() : super(LoginController()) {
    otpfunction = controller as LoginController;
  }

  TextEditingController otpcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    lisienotp();
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
                      controller: otpcontroller,
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
                  SizedBox(height: 38.h,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19.r), // <-- Radius
                      ),
                      primary: Color(0xff128041), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      if (otpcontroller.text == "") {
                        internaterror(" Filled can't be blank ", context);
                      } else {
                        otpfunction.otpVerify(otpcontroller.text, context);
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
