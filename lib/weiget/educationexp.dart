import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/educationedit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/route.dart';

// ignore: must_be_immutable
class EducationView extends StatefulWidget {
  var education;
  EducationView({this.education});

  @override
  _EducationViewState createState() => _EducationViewState(this.education);
}

class _EducationViewState extends StateMVC<EducationView> {
  var education;
  FunctionController educationController = FunctionController();
  _EducationViewState(this.education) : super(FunctionController());
  // _EducationViewState(this.education);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFfFFFf),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Institute Name: " +
                      widget.education['institute_name'].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "Passing year: " +
                      widget.education['passing_year'].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Examination: " + widget.education['examination'].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "Grade: " + widget.education['grade'].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Scale: " + widget.education['scale'].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EducationEdit(education)),
                    );
                  },
                  icon: Icon(
                    Icons.edit_note,
                    color: Colors.green,
                  ),
                  // child: Text(
                  //   "Edit",
                  //   style: TextStyle(
                  //       color: Colors.blue,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 12,
                  //       fontFamily: 'Poppins'),
                  // ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => msgthrow(context),
                    );
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                  // child: Text(
                  //   "Delete",
                  //   style: TextStyle(
                  //       color: Colors.red,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 12,
                  //       fontFamily: 'Poppins'),
                  // ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(RouteManeger.working_page);
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Color(0xFF13A30E),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
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
            educationController.educationexperincedelete(
                education['id'].toString(), context);
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
