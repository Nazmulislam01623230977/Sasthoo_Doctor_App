import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/offlinepatient.dart';

// ignore: must_be_immutable
class OfflineAppoinmentlistWeiget extends StatefulWidget {
  OfflinePatientData offlinedoctorappoinmentlist;
  OfflineAppoinmentlistWeiget({this.offlinedoctorappoinmentlist});

  @override
  State<OfflineAppoinmentlistWeiget> createState() =>
      _OfflineAppoinmentlistWeigetState();
}

class _OfflineAppoinmentlistWeigetState
    extends State<OfflineAppoinmentlistWeiget> {
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
                          'Patient Name         : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.offlinedoctorappoinmentlist.patient
                                  .firstName,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              widget
                                  .offlinedoctorappoinmentlist.patient.lastName,
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
                    padding: EdgeInsets.only(left: 33.w, right: 8.w),
                    child: Row(
                      children: [
                        Text(
                          'Patient ID                  : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          widget.offlinedoctorappoinmentlist.appoinmentId,
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
                          'Probleam                 : ',
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
                          widget.offlinedoctorappoinmentlist.problem,
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
                          'Start Time                : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          DateFormat("h:mma").format(DateTime.parse(
                              widget.offlinedoctorappoinmentlist.sheduleTime)),
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
                          'Payment Status    : ',
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
                          widget.offlinedoctorappoinmentlist.paymentStatus,
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
                          'Status                        : ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          widget.offlinedoctorappoinmentlist.status,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Align(
                  //     alignment: Alignment.topRight,
                  //     // ignore: deprecated_member_use
                  //     child: FlatButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => VideocallingPage()));
                  //       },
                  //       child: Icon(Icons.video_call),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.only(left: 33, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(
                                RouteManeger.patientdetils_page,
                                arguments: widget.offlinedoctorappoinmentlist.id
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
                                arguments: widget.offlinedoctorappoinmentlist);
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
