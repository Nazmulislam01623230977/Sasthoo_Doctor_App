import 'dart:convert';
import 'package:doctot_sasthoo/model/shedulelistmodel.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../Controller/functionController.dart';
import '../../api/apiurl.dart';
import '../../model/onlineprofilesheduile.dart';
import '../../model/profileShediule.dart';
import '../../weiget/chamberaddressweiget.dart';
import '../../weiget/onlinechamberweget.dart';

// ignore: camel_case_types
class Schedule_page extends StatefulWidget {
  const Schedule_page({Key key}) : super(key: key);

  @override
  _Schedule_pageState createState() => _Schedule_pageState();
}

// ignore: camel_case_types
class _Schedule_pageState extends StateMVC<Schedule_page> {
  FunctionController sheduleController;
  _Schedule_pageState() : super(FunctionController()) {
    sheduleController = controller as FunctionController;
  }

  bool isvisible = false;
  bool isvisible1 = false;
  bool isvisible2 = false;
  bool isvisible3 = false;
  bool isvisible5 = false;
  bool isvisible6 = false;
  bool isvisibleone = false;
  List<SheduleList> shedulelist;
  List<ProfileonlinesheduleList> onlineprofileshedulelist;
  List<ProfilesheduleList> profileshedulelist;
  bool isLoaded = false;
  shedulelistfunction() async {
    onlineprofileshedulelist =
        await FunctionController().onlineprofleshedulelist();
    if (onlineprofileshedulelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  offlibeshedulelistfunction() async {
    profileshedulelist = await FunctionController().profleshedulelist();
    if (profileshedulelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void initState() {
    shedulelistfunction();
    offlibeshedulelistfunction();
    this.userdataget();
    super.initState();
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
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 3.0), // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(1, 3))
                          ] // Make rounded corner of border
                          ),
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed(
                              RouteManeger.shecdulecreate_page);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Create New Schedule',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      color: Color(0xff128041),
                      height: 52.h,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Schedule List',
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF128041), //E9F2F2
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            child: Text('Online',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFffffff),
                                  fontWeight: FontWeight.w600,
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
                    Visibility(
                      visible: isvisible5,
                      child: onlineprofileshedulelist != null
                          ? ListView.builder(
                              itemCount: onlineprofileshedulelist.length,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var sedule = onlineprofileshedulelist[index];
                                var start = jsonDecode(sedule.startTime);
                                var endt = jsonDecode(sedule.endTime);
                                return OnlineChamberShedule(
                                    onlinechamber: sedule,
                                    starttime: start,
                                    endtime: endt);
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        isvisible = !isvisible;
                      },
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Color(0xff128041), //E9F2F2
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 8.w),
                              child: Text('Offline chamber',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                  });
                                },
                                icon: isvisible == false
                                    ? Icon(
                                        Icons.arrow_drop_down,
                                        size: 30.h,
                                        color: Color(0xFFffffff),
                                      )
                                    : Icon(
                                        Icons.arrow_drop_up,
                                        size: 30.h,
                                        color: Color(0xFFffffff),
                                      )),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isvisible,
                        child: profileshedulelist != null
                            ? ListView.builder(
                                itemCount: profileshedulelist.length,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var staff = profileshedulelist[index];
                                  return Chamberaddressweiget(
                                      chamberaddress: staff);
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
