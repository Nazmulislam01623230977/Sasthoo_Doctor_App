import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/workingexperienceedit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route/route.dart';

// ignore: must_be_immutable
class WorkingexpView extends StatefulWidget {
  var workingexp;
  WorkingexpView({Key key, this.workingexp}) : super(key: key);

  @override
  _WorkingexpViewState createState() => _WorkingexpViewState(workingexp);
}

class _WorkingexpViewState extends StateMVC<WorkingexpView> {
  var workingexp;
  FunctionController workingController = FunctionController();
  _WorkingexpViewState(this.workingexp) : super(FunctionController());
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
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
                        widget.workingexp['institute_name'].toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "Department: " + widget.workingexp['Department'].toString(),
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
                    "Designation: " +
                        widget.workingexp['designation'].toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    "Start Time: " + widget.workingexp['start_time'].toString(),
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
                    "End Time: " + widget.workingexp['end_time'].toString(),
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WorkingexperinseEdit(widget.workingexp)),
                      );
                    },
                    icon: Icon(
                      Icons.edit_note,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => msgthrow(context),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(RouteManeger.education_page);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Color(0xFF13A30E),
                    ),
                    // child: Text(
                    //   '+Add',
                    //   style: TextStyle(
                    //       color: Color(0xFF13A30E),
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 14,
                    //       fontFamily: 'Poppins'),
                    // ),
                  ),
                ],
              ),
            ]),
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
            workingController.workingexperincedelete(
                workingexp['id'].toString(), context);
            // chmmberController.chamberdelete(
            //     chambermodel['id'].toString(), context);
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
