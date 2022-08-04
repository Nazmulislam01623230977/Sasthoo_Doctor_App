import 'dart:async';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class splash_page extends StatefulWidget {
  const splash_page({Key key}) : super(key: key);

  @override
  _splash_pageState createState() => _splash_pageState();
}

// ignore: camel_case_types
class _splash_pageState extends State<splash_page> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_Page())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: 103.w, right: 104.w, top: 423.h, bottom: 424.h),
            child: Image.asset(
              "assets/images/logo.png",
              height: 79.h,
              width: 221.w,
            ),
          ),
        ),
      ),
    );
  }
}
