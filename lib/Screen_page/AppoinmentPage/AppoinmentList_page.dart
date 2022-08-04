import 'dart:convert';

import 'package:doctot_sasthoo/model/emergencypatiend.dart';
import 'package:doctot_sasthoo/model/offlinepatient.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/weiget/appointmentweiget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Componet/MainDrawer.dart';
import '../../Controller/functionController.dart';
import '../../model/patient_details_model.dart';
import '../../weiget/emergencyappoinmentweiget.dart';
import '../../weiget/offlineappoinmentweiget.dart';

// ignore: camel_case_types
class AppoinmentList_page extends StatefulWidget {
  const AppoinmentList_page({Key key}) : super(key: key);

  @override
  _AppoinmentList_pageState createState() => _AppoinmentList_pageState();
}

// ignore: camel_case_types
class _AppoinmentList_pageState extends StateMVC<AppoinmentList_page> {
  FunctionController appoinmentfunction;
  _AppoinmentList_pageState() : super(FunctionController()) {
    appoinmentfunction = controller as FunctionController;
  }
  List<PatientData> patienData;
  List<EmergencyPatientData> emergencypatient;
  List<OfflinePatientData> offlinepatient;

  var isLoaded = false;
  patientgetdata() async {
    patienData = await appoinmentfunction.patientDetatilsCont();
    if (patienData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  emergenchypatientgetdata() async {
    emergencypatient = await appoinmentfunction.emergencypatientDetatilsCont();
    if (emergencypatient != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  offlinepatientgetdata() async {
    offlinepatient = await appoinmentfunction.offlinepatientDetatilsCont();
    if (offlinepatient != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void initState() {
    super.initState();
    patientgetdata();
    emergenchypatientgetdata();
    offlinepatientgetdata();
    this.userdataget();
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
                              'assets/images/noimage.png',
                            ),
                          )),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: DefaultTabController(
          length: 3,
          child: SingleChildScrollView(
            child: Container(
              color: Color(0xFfffffff),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: Text(
                      'Appointment',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                    child: Divider(
                      color: Colors.black,
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
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                'Emergency',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                'Online',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                'Offline',
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
                  SizedBox(
                    height: 800.h,
                    child: TabBarView(children: [
                      Container(
                          child: emergencypatient != null
                              ? ListView.builder(
                                  itemCount: emergencypatient.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var emergencyappoinment =
                                        emergencypatient[index];
                                    return EmergemcyAppoinmentlistWeiget(
                                        emergencydoctorappoinmentlist:
                                            emergencyappoinment);
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )),
                      Container(
                          child: patienData != null
                              ? ListView.builder(
                                  itemCount: patienData.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var appoinment = patienData[index];
                                    return AppoinmentlistWeiget(
                                        doctorappoinmentlist: appoinment);
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )),
                      Container(
                          child: offlinepatient != null
                              ? ListView.builder(
                                  itemCount: offlinepatient.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var offlineappoinment =
                                        offlinepatient[index];
                                    return OfflineAppoinmentlistWeiget(
                                        offlinedoctorappoinmentlist:
                                            offlineappoinment);
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )),
                    ]),
                  ),
                  // ListView.builder(
                  //   itemCount: appoinmentlist.length,
                  //   scrollDirection: Axis.vertical,
                  //   physics: ScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     var appoinment = appoinmentlist[index];
                  //     return AppoinmentlistWeiget(
                  //         doctorappoinmentlist: appoinment);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Do you want to exit app?',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF247AB3),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'No',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF1F5F8),
                        fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .popAndPushNamed(RouteManeger.dashboad_page),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF2F5F7),
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ));
}
