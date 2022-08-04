import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';
import '../../route/route.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var photo;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
  }

  void initState() {
    super.initState();
    this.userdataget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: photo != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                Baseurl.mainurl +
                                    "/${photo['avater'].toString()}",
                              ))
                          : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/fonts/images/noimage.png',
                              )))),
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Text(
                  'History',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white38),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: Color(0xff128041),
                          borderRadius: BorderRadius.circular(8.r)),
                      tabs: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          child: Text(
                            'Complete',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          child: Text(
                            'Cancelled',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
