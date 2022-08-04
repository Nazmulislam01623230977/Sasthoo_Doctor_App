import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Controller/functionController.dart';
import '../route/route.dart';

// ignore: must_be_immutable
class OnlineChamberShedule extends StatefulWidget {
  var onlinechamber;
  var starttime;
  var endtime;
  OnlineChamberShedule({this.onlinechamber, this.starttime, this.endtime});
  @override
  _OnlineChamberSheduleState createState() => _OnlineChamberSheduleState(
      this.onlinechamber, this.starttime, this.endtime);
}

class _OnlineChamberSheduleState extends StateMVC<OnlineChamberShedule> {
  var onlinechamber;
  var starttime;
  var endtime;

  FunctionController shedulefunction = FunctionController();
  _OnlineChamberSheduleState(this.onlinechamber, this.starttime, this.endtime)
      : super(FunctionController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          // height: 30.h,
          decoration: BoxDecoration(
              color: Color(0xffffffff), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                      // height: 20,
                      width: 75.w,
                      child: Text(
                        onlinechamber.day.toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      )),
                ),
                // SizedBox(
                //   width: 10.w,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                      children: List.generate(starttime.length, (index) {
                    return Container(
                      // height: 15,
                      width: 50.w,
                      child: Text(
                        DateFormat("h:mma").format(DateTime.parse(
                            "${starttime[index]['value'].toString()}")),
                        style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  })),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                      width: 15.w,
                      child: Text(
                        "to",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      )),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(endtime.length, (index) {
                        return Container(
                          // height: 15,
                          width: 50.w,
                          child: Text(
                            DateFormat("h:mma").format(DateTime.parse(
                                "${endtime[index]['value'].toString()}")),
                            style: GoogleFonts.poppins(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        );
                      })),
                ),

                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
                        child: Container(
                          height: 25.h,
                          width: 25.w,
                          child: onlinechamber.activeStatus != "0"
                              ? IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          activestatusmsg(
                                              onlinechamber.id.toString(),
                                              context),
                                    );
                                  },
                                  icon: Icon(Icons.add_task_sharp,
                                      size: 15, color: Colors.green))
                              : IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          activestatusmsg(
                                              onlinechamber.id.toString(),
                                              context),
                                    );
                                  },
                                  icon: Icon(Icons.disabled_by_default,
                                      size: 15, color: Colors.red)),
                        )),
                    Padding(
                      padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
                      child: Container(
                        height: 25.h,
                        width: 25.w,
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => deletmsg(
                                    onlinechamber.id.toString(), context),
                              );
                            },
                            icon: Icon(Icons.delete,
                                size: 15, color: Colors.red)),
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

  Widget deletmsg(String id, BuildContext context) {
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
          color: Color(0xff128041),
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.white,
          child: Text("No"),
        ),
        new FlatButton(
          color: Color(0xFFCE0E0E),
          onPressed: () {
            shedulefunction.sheduleDelate(id.toString(), "profile", context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.green[200])),
          textColor: Colors.white,
          child: const Text('Yes'),
        ),
      ],
    );
  }

  Widget activestatusmsg(String id, BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Are you sure?? you want to change your status',
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
          color: Color(0xff128041),
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.white,
          child: Text("No"),
        ),
        new FlatButton(
          color: Color(0xFFCE0E0E),
          onPressed: () {
            shedulefunction.sheduleactivestatus(id.toString(), context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.green[200])),
          textColor: Colors.white,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
