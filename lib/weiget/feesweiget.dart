// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Screen_page/FeesPage/feesedit_page.dart';
import '../model/doctor_free_list.dart';
import '../route/route.dart';

class FeesListView extends StatefulWidget {
  DoctorFree feeslistdata;
  FeesListView({this.feeslistdata});
  @override
  _FeesListViewState createState() => _FeesListViewState();
}

class _FeesListViewState extends StateMVC<FeesListView> {
  FunctionController feessetupController = FunctionController();
  _FeesListViewState() : super(FunctionController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          height: 152.h,
          // height: MediaQuery.of(context).size.width * .32,
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Shedule Name: ',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          widget.feeslistdata.day,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Online Status : ',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          widget.feeslistdata.onlineStatus,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'New Fees : ',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          widget.feeslistdata.newPatientFree,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Old Fees : ',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          widget.feeslistdata.oldPatientFree,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Row(
                      children: [
                        Text(
                          'Report Fees : ',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          widget.feeslistdata.reportPatientFree,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FeesEdit_page(widget.feeslistdata)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color(0xffffffff),
                        // primary: Color(0xff31AF4E),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => msgthrow(context),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Color(0xffffffff),
                          textStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget msgthrow(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Are you sure? You want to delete',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'Poppins'),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text("No"),
        ),
        new FlatButton(
          onPressed: () {
            feessetupController.feesdelete(
                widget.feeslistdata.id.toString(), context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.green[200])),
          textColor: Colors.black,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
