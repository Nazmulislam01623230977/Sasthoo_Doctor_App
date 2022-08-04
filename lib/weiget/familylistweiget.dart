import 'package:doctot_sasthoo/Controller/functionController.dart';

import 'package:doctot_sasthoo/model/familymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class Familylistweiget extends StatefulWidget {
  Familymodel familylistmodel;
  Familylistweiget({this.familylistmodel});

  @override
  _FamilylistweigetState createState() =>
      _FamilylistweigetState(this.familylistmodel);
}

class _FamilylistweigetState extends StateMVC<Familylistweiget> {
  var familylistmodel;
  FunctionController familylistController = FunctionController();
  _FamilylistweigetState(this.familylistmodel) : super(FunctionController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15.h,
              left: 16.w,
              right: 16.w,
            ),
            height: 110.h,
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
            child: ListView(
              children: [
                Row(
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
                              'Name : ',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              widget.familylistmodel.firstname,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              widget.familylistmodel.lastname,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender : ',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 2.sp,
                            ),
                            Text(
                              widget.familylistmodel.gender,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Num : ',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              widget.familylistmodel.phone,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Relation : ',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              widget.familylistmodel.relation,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                // fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff), //E9F2F2
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                msgthrow(context),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Familylist(familylistmodel)),
                          // );
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          size: 30,
                          color: Colors.red,
                        ),
                        // child: Text(
                        //   'Delete',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.red,
                        //     fontFamily: 'Poppins',
                        //   ),
                        // )
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ],
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
            familylistController.familylistdelete(
                familylistmodel.id.toString(), context);
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
