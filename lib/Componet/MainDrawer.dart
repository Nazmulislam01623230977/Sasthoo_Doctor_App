import 'package:doctot_sasthoo/Controller/loginController.dart';
import 'package:doctot_sasthoo/Screen_page/AppoinmentPage/AppoinmentList_page.dart';
import 'package:doctot_sasthoo/Screen_page/ChamberPage/ChamberSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/FeesPage/FeeSetup_page.dart';

import 'package:doctot_sasthoo/Screen_page/WalletPage/Wallet_page.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Screen_page/historypage/historypage.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends StateMVC<MainDrawer> {
  bool value;
  LoginController logoutfunction;
  _MainDrawerState() : super(LoginController()) {
    logoutfunction = controller as LoginController;
  }

  void internaterror(String massge, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(massge),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  cerculerShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Color(0xff464645),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  color: Color(0xff464645),
                  child: Container(
                    height: 210.h,
                    // height: MediaQuery.of(context).size.height * 0.21,
                    // width: MediaQuery.of(context).size.width * 0.09,
                    // margin: EdgeInsets.only(
                    //   top: 10,
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                'Emergency',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            buildSwitch(),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/icon.png',
                              height: 30.h,
                              width: 50.w,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Digital Shastho',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp,
                                color: Color(0xFFFFFFFF),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: Divider(
                            color: Color(0xFFB8B8B8),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Home',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.home_page);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Profile',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.profile_page);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.chalet_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Chamber',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChamberSetup_page()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Schedule',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.shecduleshow_page);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Fees',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeeSetup_page()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Appointment',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppoinmentList_page()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.person_add_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Assistant',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.staff_page);
                    }),
                ListTile(
                    leading: Icon(Icons.person_pin_circle_outlined,
                        color: Colors.white),
                    title: Text(
                      'Family Member',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.familysearch_page);
                    }),
                // ListTile(
                //     leading: Icon(
                //       Icons.search,
                //       color: Colors.white,
                //     ),
                //     title: Text(
                //       'Family Setup',
                //       style: GoogleFonts.roboto(
                //         color: Colors.white,
                //         fontSize: 13,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.of(context)
                //           .popAndPushNamed(RouteManeger.familysearch_page);
                //     }),
                ListTile(
                    leading: Icon(
                      Icons.wallet_travel_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Wallet',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Wallet_page()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.card_travel_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Transection',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.trangeciton_page);
                    }),
                // ListTile(
                //     leading: Icon(
                //       Icons.folder_special,
                //       color: Colors.white,
                //     ),
                //     title: Text(
                //       'Specialist',
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.of(context)
                //           .popAndPushNamed(RouteManeger.addspecialist_page);
                //     }),
                // ListTile(
                //     leading: Icon(
                //       Icons.pages,
                //       color: Colors.white,
                //     ),
                //     title: Text(
                //       'Prescription',
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => Prescription_page("")));
                //     }),
                // ListTile(
                //     leading: Icon(Icons.room_preferences, color: Colors.white),
                //     title: Text(
                //       'Refer Patient',
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ReferPatient_page()));
                //     }),
                // ListTile(
                //     leading: Icon(
                //       Icons.report,
                //       color: Colors.white,
                //     ),
                //     title: Text(
                //       'Report',
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => Reportlist_page()));
                //     }),
                ListTile(
                    leading: Icon(
                      Icons.history_sharp,
                      color: Colors.white,
                    ),
                    title: Text(
                      'History',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()));
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      logoutfunction.logout(context);
                    },
                    child: Container(
                      color: Color(0xFF128041), //128041,
                      width: double.infinity,
                      child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Logout',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            logoutfunction.logout(context);
                            // _logout();
                            // logoutfunction._logout();
                            // _logout(context);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1.2,
        child: Switch.adaptive(
            activeColor: Color(0xFF128041),
            inactiveThumbColor: Colors.red,
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            }),
      );
}
