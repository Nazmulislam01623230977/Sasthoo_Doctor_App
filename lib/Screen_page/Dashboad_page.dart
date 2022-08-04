import 'dart:convert';
import 'package:doctot_sasthoo/Componet/MainDrawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/functionController.dart';
import '../model/emergencypatiend.dart';
import '../model/offlinepatient.dart';
import '../model/patient_details_model.dart';
import '../model/speciality_model.dart';
import '../route/route.dart';

// ignore: camel_case_types
class Dashboad_page extends StatefulWidget {
  const Dashboad_page({Key key}) : super(key: key);

  @override
  _Dashboad_pageState createState() => _Dashboad_pageState();
}

// ignore: camel_case_types
class _Dashboad_pageState extends StateMVC<Dashboad_page> {
  bool _value = false;
  int val = -1;
  double rating = 0;

  List onlinepatient = [];
  final urlImages = [
    'assets/images/D-S app banner - 2-01.jpg',
    'assets/images/D-S app banner-01.jpg',
    'assets/images/D-S app banner-3-01.jpg',
    'assets/images/D-S app banner-4-01.jpg',
  ];

  LoginController userdatafunction;
  _Dashboad_pageState() : super(LoginController()) {
    userdatafunction = controller as LoginController;
  }
  List<Speicality> speciallistdataa;
  bool isLoaded = false;
  speciallistlistfunction() async {
    speciallistdataa = await FunctionController().specialitylist();
    if (speciallistdataa != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  List<PatientData> todaypatinet;
  patientgetdata() async {
    todaypatinet = await userdatafunction.todaypatient();
    if (todaypatinet != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  var userdatashowdecode;
  var userdatashow;
  var photo;
  DateTime datetime = DateTime.now();

  List<PatientData> patienData;
  List<EmergencyPatientData> emergencypatient;
  List<OfflinePatientData> offlinepatient;
  int totalpatient;
  int onlinopatient;
  patientgetdataa() async {
    patienData = await FunctionController().patientDetatilsCont();
    if (patienData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  emergenchypatientgetdata() async {
    emergencypatient =
        await FunctionController().emergencypatientDetatilsCont();
    if (emergencypatient != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  offlinepatientgetdata() async {
    offlinepatient = await FunctionController().offlinepatientDetatilsCont();
    if (offlinepatient != null) {
      setState(() {
        isLoaded = true;
        emergencypatient = emergencypatient;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userdatafunction.userdata(context);
    speciallistlistfunction();
    userdatashoww();
    patientgetdata();
    patientgetdataa();
    emergenchypatientgetdata();
    offlinepatientgetdata();
  }

  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
  }

  userdatashoww() async {
    await userdataget();
    setState(() {
      userdatashowdecode = jsonDecode(userdatashow);
      photo = userdatashowdecode['photo'];
    });
    // print(userdatashowdecode);
    // print(photo);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await userdatafunction.showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
          backgroundColor: Color(0xffF3FAF8), //F3FAF8
          appBar: AppBar(
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
                            radius: 18.r, // Image radius
                            backgroundImage: NetworkImage(
                              Baseurl.mainurl +
                                  "/${photo['avater'].toString()}",
                            ))
                        : CircleAvatar(
                            radius: 18.r, // Image radius
                            backgroundImage: AssetImage(
                              
                              'assets/fonts/images/noimage.png',
                              // fit:BoxFit.fill  
                            ),
                            
                          )),
              ),
            ],
          ),
          drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff128041),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      )),
                  // height: MediaQuery.of(context).size.height * .14,
                  height: 130.h,
                  width: 428.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 50.w, top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                            child: photo != null
                                ? Material(
                                    color: Colors.white,
                                    child: Image.network(
                                      Baseurl.mainurl +
                                          "/${photo['avater'].toString()}",
                                      height: 90.h,
                                      width: 80.w,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Material(
                                    color: Colors.white,
                                    child: Image.asset(
                                      'assets/images/pic.png',
                                      height: 90.h,
                                      width: 80.w,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userdatashowdecode['title'].toString() +
                                  " " +
                                  userdatashowdecode['first_name'].toString() +
                                  " " +
                                  userdatashowdecode['last_name'].toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            speciallistdataa != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        speciallistdataa.length, (index) {
                                      return Text(
                                        "Speciality: " +
                                            speciallistdataa[index].specialitie,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    }))
                                : Center(
                                    child: Text(""),
                                  ),
                            Row(
                              children: [
                                RatingBar.builder(
                                    initialRating: 5,
                                    itemSize: 12.h,
                                    minRating: 1,
                                    itemBuilder: (_, context) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) => setState(() {
                                          this.rating = rating;
                                        })),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '(0 review)',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 15.h),
                  child: Center(
                    child: CarouselSlider.builder(
                        itemCount: urlImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage = urlImages[index];
                          return buildImage(urlImage, index);
                        },
                        options: CarouselOptions(
                          height: 114.h,

                          // height: MediaQuery.of(context).size.height * .12,
                          autoPlay: true,
                          aspectRatio: 1 / 2,
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 120.h,
                      width: 189.w,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          todaypatinet != null && todaypatinet != []
                              ? Text(
                                  todaypatinet.length.toString(),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25.sp,
                                    color: Color(0xFF000000),
                                  ),
                                )
                              : Text(
                                  "0",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25.sp,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                          Text(
                            'Today’s patient',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 8.h,
                                width: 8.w,
                                // margin: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFF15C83C),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              todaypatinet != null
                                  ? Text(
                                      "Total online: " +
                                          todaypatinet.length.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Color(0xFF000000),
                                      ),
                                    )
                                  : Text(
                                      "Total online: 0",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  // margin: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD0BC04),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Total offline: 20",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      height: 120.h,
                      width: 187.w,
                      // height: MediaQuery.of(context).size.height * 0.16,
                      // width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Color(0xff0097E6), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          todaypatinet != null
                              ? Text(
                                  todaypatinet.length.toString(),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40.sp,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )
                              : Text(
                                  "0",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40.sp,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                          Text(
                            'Patient in queue',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 120.h,
                      width: 189.w,
                      // height: MediaQuery.of(context).size.height * 0.16,
                      // width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Color(0xffFF4C4C), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            emergencypatient != null
                                ? Text(
                                    emergencypatient.length.toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 40.sp,
                                      color: Color(0xFFffffff),
                                    ),
                                  )
                                : Text(
                                    "0",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 40.sp,
                                      color: Color(0xFFffffff),
                                    ),
                                  ),
                            Text(
                              'Emergency patient',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xFFfffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      height: 120.h,
                      width: 188.w,
                      // height: MediaQuery.of(context).size.height * 0.16,
                      // width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: onlinopatient != null
                                  ? Text(
                                      onlinopatient.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                        color: Color(0xFF0A3496),
                                      ),
                                    )
                                  : Text(
                                      '0',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                        color: Color(0xFF0A3496),
                                      ),
                                    )),
                          Center(
                            child: Text(
                              'Total appointment',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 8.h,
                                width: 8.w,
                                // margin: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFF15C83C),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              patienData != null
                                  ? Text(
                                      "Total online: " +
                                          patienData.length.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Color(0xFF000000),
                                      ),
                                    )
                                  : Text(
                                      "Total online: 0",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  // margin: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD0BC04),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                offlinepatient != null
                                    ? Text(
                                        "Total offline:" +
                                            offlinepatient.length.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: Color(0xFF000000),
                                        ),
                                      )
                                    : Text(
                                        "Total offline: 0",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 319.w),
                  child: Text(
                    'Be a Donor',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 140.h,
                      width: 188.w,
                      // height: MediaQuery.of(context).size.height * 0.18,
                      // width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/blooddonation.png',
                            height: 60.h,
                            width: 60.w,
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Text(
                            'Blood Donate',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 140.h,
                      width: 188.w,
                      // height: MediaQuery.of(context).size.height * 0.18,
                      // width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/donation.png',
                            height: 60.h,
                            width: 60.w,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            'Donation',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        color: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          // child: Image.network(
          //   urlImage,
          //   width: 388.w,
          //   height: 114.h,
          //   fit: BoxFit.fill,
          // ),

          child: Image.asset(
            urlImage,
            height: 94.h,
            width: 388.w,
            fit: BoxFit.cover,
          ),
        ),
      );
}
