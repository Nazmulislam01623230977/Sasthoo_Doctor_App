import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/stafflistedit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class StafflistView extends StatefulWidget {
  var stafflist;
  StafflistView({this.stafflist});

  @override
  _StafflistViewState createState() => _StafflistViewState(this.stafflist);
}

class _StafflistViewState extends StateMVC<StafflistView> {
  var stafflist;
  FunctionController staflistController = FunctionController();
  _StafflistViewState(this.stafflist) : super(FunctionController());
  // _StafflistViewState(stafflist);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        //side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.w, top: 12.h, right: 16.w, bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tittle                        : ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${stafflist['title'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Name                  : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "${stafflist['first_name'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${stafflist['last_name'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Gender                  : ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${stafflist['gender'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Email                      : ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${stafflist['email'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone                    : ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${stafflist['phone'].toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Stafflisteditpage(stafflist)));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Color(0xffffffff),
                      textStyle: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
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
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
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
        new FlatButton(
          onPressed: () {
            staflistController.staffdelete(stafflist['id'].toString(), context);
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
