import 'dart:io';

import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpoverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ignore: missing_return
      builder: (context, child) => MaterialApp(
        initialRoute: RouteManeger.loginmainpage,
        onGenerateRoute: RouteManeger.generateroute,
        debugShowCheckedModeBanner: false,
      ),
      // builder: (BuildContext context, Widget child) {
      // MaterialApp(
      //   initialRoute: RouteManeger.loginmainpage,
      //   onGenerateRoute: RouteManeger.generateroute,
      //   debugShowCheckedModeBanner: false,
      // );
      // },
      designSize: Size(428, 926),
    );
  }
}

// more example: https://github.com/flutterchina/dio/tree/master/example

class LoginFunction extends StatefulWidget {
  @override
  _LoginFunctionState createState() => _LoginFunctionState();
}

class _LoginFunctionState extends State<LoginFunction> {
  var token;
  _askquetionforpage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    print('$token');

    if (token != null) {
      Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page);
      print('$token');
    }

    if (token == null) {
      Navigator.of(context).popAndPushNamed(RouteManeger.splashs_page);
    }
  }

  @override
  void initState() {
    super.initState();
    this._askquetionforpage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
