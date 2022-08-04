// ignore_for_file: must_be_immutable

import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/route.dart';

class SpeciallstWeiget extends StatefulWidget {
  var dspecilestlist;
  var speciest;
  SpeciallstWeiget({this.dspecilestlist, this.speciest});

  @override
  _SpeciallstWeigetState createState() =>
      _SpeciallstWeigetState(this.dspecilestlist, this.speciest);
}

class _SpeciallstWeigetState extends StateMVC<SpeciallstWeiget> {
  var dspecilestlist;
  var speciest;
  FunctionController specialestController = FunctionController();
  _SpeciallstWeigetState(this.dspecilestlist, this.speciest)
      : super(FunctionController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Container(
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
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specialist : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        dspecilestlist.specialitie,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          children: List.generate(
                        speciest.length,
                        (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sub specialist : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins'),
                              ),
                              Text(
                                "${speciest[index]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          );
                        },
                      ))
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff), //E9F2F2
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    size: 25.h,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => msgthrow(context),
                    );
                  },
                  // child: Text('Delete'),
                ),
              ),
            ],
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
        // ignore: deprecated_member_use
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
            specialestController.spiceistdelete(
                dspecilestlist.id.toString(), context);
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
