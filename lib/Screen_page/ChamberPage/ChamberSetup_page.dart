import 'dart:convert';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/chamberweiget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import '../../Componet/MainDrawer.dart';

// ignore: camel_case_types
class ChamberSetup_page extends StatefulWidget {
  const ChamberSetup_page({Key key}) : super(key: key);

  @override
  _ChamberSetup_pageState createState() => _ChamberSetup_pageState();
}

// ignore: camel_case_types
class _ChamberSetup_pageState extends State<ChamberSetup_page> {
  var userdatashow;
  var userid;
  var photo;
  List chamberlist = [];
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    photo = userdata['photo'];
    userid = userdata['id'];
  }

// ==========================
  chamberlistfunction() async {
    await userdataget();
    var url = ApiRepo.chamberlist + "${userid}";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );

    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      print(jsonData);
      setState(() {
        chamberlist = jsonData['result'];
      });
      print(chamberlist);
    });
  }

// =====================

  void initState() {
    super.initState();
    this.chamberlistfunction();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h),
                child: Text(
                  'Chamber List',
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.h, bottom: 2.h, left: 20.w, right: 20.w),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Container(
                  height: 52.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                          color: Colors.black87, // Set border color
                          width: 3.0), // Set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // Set rounded corner radius
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.white,
                            offset: Offset(1, 3))
                      ] // Make rounded corner of border
                      ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.chamberedit_page);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF128041),
                        textStyle: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    child: Text(' Add new chamber+',
                        style: GoogleFonts.roboto(
                          color: Color(0xFFffffff),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                child: Container(
                  color: Color(0xFF128041),
                  height: 52.h,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Chamber list',
                          style: GoogleFonts.roboto(
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: chamberlist.length > 0
                        ? ListView.builder(
                            itemCount: chamberlist.length,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var chamber = chamberlist[index];
                              return ChmberWeiget(chambermodel: chamber);
                            },
                          )
                        : Center(child: Text('')
                            // CircularProgressIndicator(),
                            )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
