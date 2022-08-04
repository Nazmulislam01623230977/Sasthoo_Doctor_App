import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Controller/functionController.dart';
import '../model/doctor_free_list.dart';

class OnlineFreeShedule extends StatefulWidget {
  DoctorFree onlineFree;

  OnlineFreeShedule({
    this.onlineFree,
  });
  @override
  _OnlineFreeSSheduleState createState() => _OnlineFreeSSheduleState();
}

class _OnlineFreeSSheduleState extends StateMVC<OnlineFreeShedule> {
  FunctionController shedulefunction = FunctionController();
  _OnlineFreeSSheduleState() : super(FunctionController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        // decoration: BoxDecoration(
        //     color: Color(0xffffffff), //E9F2F2
        //     borderRadius: BorderRadius.circular(10),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black54,
        //         blurRadius: 1,
        //         offset: Offset(0, 1),
        //       )
        //     ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 20,
                              width: 75,
                              child: Text(
                                widget.onlineFree.day,
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.onlineFree.newPatientFree,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.onlineFree.oldPatientFree,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.onlineFree.reportPatientFree,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       height: 20,
                          //       width: 70,
                          //       // ignore: deprecated_member_use
                          //       child: FlatButton(
                          //           onPressed: () {
                          //             shedulefunction.sheduleDelate(
                          //                 onlinechamber.id.toString(), context);
                          //           },
                          //           child: Icon(Icons.delete,
                          //               size: 13, color: Colors.red)),
                          //     ),
                          //     SizedBox(
                          //       height: 30,
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
