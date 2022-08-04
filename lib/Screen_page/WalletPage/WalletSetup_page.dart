import 'dart:convert';

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../api/apiurl.dart';

// ignore: camel_case_types
class WalletSetup_page extends StatefulWidget {
  const WalletSetup_page({Key key}) : super(key: key);

  @override
  _WalletSetup_pageState createState() => _WalletSetup_pageState();
}

// ignore: camel_case_types
class _WalletSetup_pageState extends StateMVC<WalletSetup_page> {
  FunctionController walletController = FunctionController();
  _WalletSetup_pageState() : super(FunctionController());

  TextEditingController accountnameController = TextEditingController();
  TextEditingController accountnumController = TextEditingController();
  TextEditingController branchnameController = TextEditingController();

  String _accounttype;
  String _bankname;

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
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.wallet_page),
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
                    'Wallet Create',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
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
                  padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 16.w),
                  child: Text(
                    "Account Type",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                    ), //596970
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                    height: 52.h,
                    alignment: Alignment.centerLeft,
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
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: _accounttype == null
                              ? Text(
                                  'a/c type',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  _accounttype,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.h,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                          items:
                              ['Bank', 'mobile Banking', 'Bkash', 'Nagad'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _accounttype = val;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "Bank Name",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                    ), //596970
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                    height: 52.h,
                    alignment: Alignment.centerLeft,
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
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: _bankname == null
                              ? Text(
                                  'bank name',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  _bankname,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.h,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                          items: [
                            'Prime Bank',
                            'Dutch Bangla Bank',
                            'AB bank',
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _bankname = val;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                buildAccountName(accountnameController, context),
                SizedBox(
                  height: 5.h,
                ),
                buildAccountNumber(accountnumController, context),
                SizedBox(
                  height: 5.h,
                ),
                buildBranchName(branchnameController, context),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: SizedBox(
                      height: 52.h,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (accountnameController.text == "") {
                              internaterror(" Filled can't be blank ", context);
                            } else if (accountnumController.text.length != 17) {
                              internaterror(
                                  "Account number must be 17 digits ", context);
                            } else if (branchnameController.text == "") {
                              internaterror("Filled can't be blank", context);
                            } else {
                              walletController.walletsetup(
                                  _accounttype,
                                  _bankname,
                                  accountnameController.text,
                                  accountnumController.text,
                                  branchnameController.text,
                                  context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff128041),
                              textStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildAccountName(accountnameController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Account Name",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
              controller: accountnameController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // prefixIcon: Icon(
                  //   Icons.replay_5_outlined,
                  //   color: Color(0xffA7ADBC),
                  // ),
                  hintText: 'Account Name',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  )), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAccountNumber(accountnumController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Account Number",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
              controller: accountnumController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0XXX',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  )), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBranchName(branchnameController, context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 2.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Branch Name",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ), //596970
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 52.h,
          alignment: Alignment.centerLeft,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: TextFormField(
              controller: branchnameController,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ab bank ,mirpur 14',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  )), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
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
