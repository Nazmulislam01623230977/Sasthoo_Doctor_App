import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/patient_details_model.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PandingTransaction extends StatefulWidget {
  PatientData paindingamountt;
  PandingTransaction({this.paindingamountt});
  @override
  _PandingTransactionState createState() => _PandingTransactionState();
}

class _PandingTransactionState extends State<PandingTransaction> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      // margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xffffffff), //E9F2F2
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 32.w, top: 20.h),
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: Color(0xff53A877),
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(60.r),
              ),
              child: Image.asset(
                'assets/images/download.png',
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.paindingamountt.patient.firstName +
                          " " +
                          widget.paindingamountt.patient.lastName,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 100),
                    //     child: Text(
                    //       widget.paindingamountt.fee + " tk",
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 15,
                    //         color: Colors.green,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(
                          DateTime.parse(widget.paindingamountt.createdAt)),
                      style: GoogleFonts.poppins(
                        fontSize: 8.sp,
                        color: Color(0xff757575),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      DateFormat("h:mma").format(
                          DateTime.parse(widget.paindingamountt.createdAt)),
                      style: GoogleFonts.poppins(
                        fontSize: 8.sp,
                        color: Color(0xff757575),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              widget.paindingamountt.fee + " tk",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
