import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Screen_page/videocall_page.dart';
import '../model/emergencypatiend.dart';
import '../model/patient_details_model.dart';

// ignore: must_be_immutable
class EmergemcyAppoinmentlistWeiget extends StatefulWidget {
  EmergencyPatientData emergencydoctorappoinmentlist;
  EmergemcyAppoinmentlistWeiget({this.emergencydoctorappoinmentlist});

  @override
  State<EmergemcyAppoinmentlistWeiget> createState() =>
      _EmergencyAppoinmentlistWeigetState();
}

class _EmergencyAppoinmentlistWeigetState
    extends State<EmergemcyAppoinmentlistWeiget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Stack(
          children: [
            Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.w),
                    child: Row(
                      children: [
                        Text(
                          'Patient Name          : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.emergencydoctorappoinmentlist.patient
                                  .firstName,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              widget.emergencydoctorappoinmentlist.patient
                                  .lastName,
                              // "${doctorappoinmentlist.lastName.toString()}",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.h),
                    child: Row(
                      children: [
                        Text(
                          'Patient ID                   : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          widget.emergencydoctorappoinmentlist.appoinmentId,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.h),
                    child: Row(
                      children: [
                        Text(
                          'Probleam                  : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          widget.emergencydoctorappoinmentlist.problem,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.w),
                    child: Row(
                      children: [
                        Text(
                          'Start Time                 : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          DateFormat("h:mma").format(DateTime.parse(widget
                              .emergencydoctorappoinmentlist.sheduleTime)),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.w),
                    child: Row(
                      children: [
                        Text(
                          'Payment Status     : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          widget.emergencydoctorappoinmentlist.paymentStatus,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.h),
                    child: Row(
                      children: [
                        Text(
                          'Status                         : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          widget.emergencydoctorappoinmentlist.status,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideocallingPage()));
                        },
                        child: Icon(Icons.video_call),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(
                                RouteManeger.patientdetils_page,
                                arguments: widget
                                    .emergencydoctorappoinmentlist.id
                                    .toString());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffC5C5C5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 5.h),
                            child: Text(
                              'Details',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(
                                RouteManeger.prescription,
                                arguments:
                                    widget.emergencydoctorappoinmentlist);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 5.h),
                            child: Text(
                              'Make prescription',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
