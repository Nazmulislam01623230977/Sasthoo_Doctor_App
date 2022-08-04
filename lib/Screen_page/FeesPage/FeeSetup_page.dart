// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:doctot_sasthoo/Screen_page/FeesPage/AddFees_page.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../Controller/functionController.dart';
import '../../api/apiurl.dart';
import '../../model/doctorOfflinefree.dart';
import '../../model/doctor_free_list.dart';
import '../../weiget/feesweiget.dart';
import '../../weiget/offlinefeesweiget.dart';
import '../../weiget/onlinefreewidet.dart';

class FeeSetup_page extends StatefulWidget {
  const FeeSetup_page({Key key}) : super(key: key);

  @override
  _FeeSetup_pageState createState() => _FeeSetup_pageState();
}

class _FeeSetup_pageState extends State<FeeSetup_page> {
  List<DoctorFree> freelist;
  List<OffilleDoctorFree> offllinefreelist;

  bool isvisible = false;
  bool isvisible1 = false;
  bool isvisible2 = false;
  bool isvisible3 = false;
  bool isvisible5 = false;
  bool isvisible6 = false;
  bool isvisibleone = false;
  bool isLoaded = false;
  freelistfunction() async {
    freelist = await FunctionController().doctorfree();
    if (freelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  offlinefreelistfunction() async {
    offllinefreelist = await FunctionController().offlinedoctorfree();
    if (offllinefreelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

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
    freelistfunction();
    offlinefreelistfunction();
    this.userdataget();
    super.initState();
  }
// =====================

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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'Fess List',
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
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
                  child: Container(
                    height: 52.h,
                    // height: MediaQuery.of(context).size.height * 0.06,
                    width: double.maxFinite,
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
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddFess_page()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            textStyle: GoogleFonts.poppins(
                                fontSize: 15.sp, fontWeight: FontWeight.w500)),
                        child: Text('Create New Fee ')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF128041), //E9F2F2
                        borderRadius: BorderRadius.circular(5.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text('Online',
                              style: GoogleFonts.poppins(
                                color: Color(0xFFffffff),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible5 = !isvisible5;
                              });
                            },
                            icon: isvisible5 == false
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 30.h,
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                    size: 30.h,
                                  ))
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isvisible5,
                  child: freelist != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 5.h, bottom: 5.h),
                          child: ListView.builder(
                            itemCount: freelist.length,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var onelinefree = freelist[index];
                              return FeesListView(
                                feeslistdata: onelinefree,
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(''),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h,),
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF128041), //E9F2F2
                        borderRadius: BorderRadius.circular(5.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text('Offline chamber free',
                              style: GoogleFonts.poppins(
                                color: Color(0xFFffffff),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible6 = !isvisible6;
                              });
                            },
                            icon: isvisible6 == false
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 30.h,
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                    size: 30.h,
                                  ))
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isvisible6,
                  child: offllinefreelist != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 5.h),
                          child: ListView.builder(
                            itemCount: offllinefreelist.length,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var offlinefree = offllinefreelist[index];
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5.h),
                                child: OfflineFeesListView(
                                  offllinefeeslistdata: offlinefree,
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
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
