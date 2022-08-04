import 'dart:convert';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/StaffSetup_page.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/stafflistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Componet/MainDrawer.dart';

// ignore: camel_case_types
class Stafflist_page extends StatefulWidget {
  const Stafflist_page({Key key}) : super(key: key);

  @override
  _Stafflist_pageState createState() => _Stafflist_pageState();
}

// ignore: camel_case_types
class _Stafflist_pageState extends State<Stafflist_page> {
  var userdatashow;
  var id;
  List stafflist = [];
  var photo;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    id = userdata['id'];
    setState(() {
      photo = userdata['photo'];
    });
  }

  stafflistfunction() async {
    await userdataget();
    var url = ApiRepo.stafflist + "${id}";
    print(url);
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      print(jsonData);
      this.setState(() {
        stafflist = jsonData['result'];
        print(stafflist);
      });
    });
  }

  void initState() {
    super.initState();
    stafflistfunction();
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
        body: WillPopScope(
          onWillPop: () =>
              Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: Text(
                      'Assistant list',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 2.h, bottom: 2.h),
                    child: Divider(
                      color: Color(0xff000000),
                      // color: Color(0xff959595),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
                    child: Container(
                        height: 52.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(
                                color: Colors.black87, // Set border color
                                width: 3.0), // Set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // Set rounded corner radius
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.white,
                                  offset: Offset(1, 3))
                            ] // Make rounded corner of border
                            ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StaffSetup_page()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff128041),
                              textStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          child: Text(
                            '+ Add Assistant',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: ListView.builder(
                      itemCount: stafflist.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var staff = stafflist[index];
                        return StafflistView(stafflist: staff);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
