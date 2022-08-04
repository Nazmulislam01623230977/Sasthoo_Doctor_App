import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class UpdatePasswordPage extends StatefulWidget {
  var phone;
  UpdatePasswordPage(this.phone);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends StateMVC<UpdatePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  var phone;
  bool passwordVisible;
  bool conpasswordVisible;
  LoginController confirmfunction;
  _UpdatePasswordPageState() : super(LoginController()) {
    confirmfunction = controller as LoginController;
  }
  // late LoginCotroller _con;
  // _UpdatePasswordPageState(this.phone) : super(LoginCotroller()) {
  //   _con = controller as LoginCotroller;
  // }

  @override
  void initState() {
    passwordVisible = false;
    conpasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 10.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Text(
                  'Your new password must be different from old password.',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: Text(
            //     'New Password ',
            // style: GoogleFonts.poppins(
            //     fontSize: 12.sp, fontWeight: FontWeight.w400),
            //   ),
            // ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Password",
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 52.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                        obscureText: !passwordVisible,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            // color: pcolor,
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                                passwordVisible
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off,
                                size: 15.h,
                                color: Color(
                                    0xffABABAB) //Theme.of(context).primaryColorDark,
                                ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          // hintText: 'New Password',
                          // hintStyle: GoogleFonts.poppins(
                          //     fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirm password",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 52.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: TextFormField(
                        controller: confirmpasswordController,
                        obscureText: !conpasswordVisible,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            // color: pcolor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                conpasswordVisible
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off,
                                size: 15.h,
                                color: Color(
                                    0xffABABAB) //Theme.of(context).primaryColorDark,
                                ),
                            onPressed: () {
                              setState(() {
                                conpasswordVisible = !conpasswordVisible;
                              });
                            },
                          ),
                          // hintText: 'Confirm password',
                          // hintStyle:
                          //     TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black)),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                color: Color(0xff128041),
                height: 52.h,
                width: double.infinity,
                // ignore: deprecated_member_use
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .popAndPushNamed(RouteManeger.loginin_page);
                    if (passwordController.text == "") {
                      _loginToast("Password con not be empty", context);
                    } else if (confirmpasswordController.text == "") {
                      _loginToast("Confirm password con not be empty", context);
                    } else if (passwordController.text.length < 8) {
                      _loginToast("Password will minmum 8 charecter", context);
                    } else if (passwordController.text !=
                        confirmpasswordController.text) {
                      _loginToast(
                          "Password and  Confirm password doesn\'t match",
                          context);
                    } else {
                      //  confirmfunction.confirmpassword(){

                      //  }
                      confirmfunction.confirmpassword(passwordController.text,
                          confirmpasswordController.text, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff128041),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildname(fullNameController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Full name",
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: TextFormField(
          controller: fullNameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.person,
                // color: pcolor,
              ),
              hintText: 'Full name',
              hintStyle:
                  TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black)),
        ),
      )
    ],
  );
}

Widget buildEmail(emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Email",
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.email,
                // color: pcolor,
              ),
              hintText: 'Email',
              hintStyle:
                  TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black)),
        ),
      )
    ],
  );
}

Widget buildBar(barAssNameController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Bar Association Name",
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: TextFormField(
          controller: barAssNameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.commute,
                // color: pcolor,
              ),
              hintText: 'Bar Association Name',
              hintStyle:
                  TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black)),
        ),
      )
    ],
  );
}

void _loginToast(String massge, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(massge),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
