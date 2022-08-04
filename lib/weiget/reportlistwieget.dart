import 'package:doctot_sasthoo/model/reportlistmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportListWeiget extends StatelessWidget {
  final ReportListModel reportlist;
  const ReportListWeiget({Key key, this.reportlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              height: MediaQuery.of(context).size.width * .33,
              decoration: BoxDecoration(
                  color: Color(0xffffffff), //E9F2F2
                  borderRadius: BorderRadius.circular(10),
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
                    children: [
                      Text(
                        'Appointment Id: ',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        reportlist.apid,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'Patient Name : ',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        reportlist.patientname,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'Report Name : ',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        reportlist.reportname,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'Report Date : ',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        reportlist.reportdate,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => feedback_page()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff128041),
                          textStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: Text(
                        reportlist.show,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
