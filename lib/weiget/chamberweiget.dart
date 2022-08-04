// ignore_for_file: deprecated_member_use

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/ChamberPage/chamberedit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/route.dart';

// ignore: must_be_immutable
class ChmberWeiget extends StatefulWidget {
  var chambermodel;
  ChmberWeiget({Key key, this.chambermodel}) : super(key: key);
  @override
  _ChmberWeigetState createState() => _ChmberWeigetState(this.chambermodel);
}

class _ChmberWeigetState extends StateMVC<ChmberWeiget> {
  var chambermodel;
  FunctionController chmmberController = FunctionController();
  _ChmberWeigetState(this.chambermodel) : super(FunctionController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Padding(
        padding:
            EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w, bottom: 10.h),
        child: Stack(
          children: [
            Container(
              height: 134.h,
              // height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          // top: 18.h,
                          left: 16.w,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Chamber Name: ',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              "${chambermodel['chamber_name'].toString()}",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, top: 2.h),
                        child: Row(
                          children: [
                            Text(
                              'Address: ',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              "${chambermodel['address'].toString()}",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, top: 2.h),
                        child: Row(
                          children: [
                            Text(
                              'Description: ',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              "${chambermodel['description'].toString()}",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChamberPage(chambermodel)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color(0xffffffff),
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        child: Icon(
                          Icons.edit,
                          color: Colors.green,
                          size: 15.h,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                msgthrow(context),
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
                          size: 15.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        // ignore: deprecated_member_use
        new FlatButton(
          onPressed: () {
            chmmberController.chamberdelete(
                chambermodel['id'].toString(), context);
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
