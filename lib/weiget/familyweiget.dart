import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/model/familymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../bloc/famillyadd_bloc.dart';
import '../events/famillysetup_events.dart';

// ignore: must_be_immutable
class FamillyWeiget extends StatefulWidget {
  Familymodel familly;
  FamillyWeiget({this.familly});

  @override
  _FamillyWeigetState createState() => _FamillyWeigetState(this.familly);
}

class _FamillyWeigetState extends StateMVC<FamillyWeiget> {
  var famillylist;
  String rellation;
  FunctionController famillylistController = FunctionController();
  _FamillyWeigetState(this.famillylist) : super(FunctionController());

  TextEditingController relatincontroller = TextEditingController();

  final _famillybloc = FamilyRelationBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
            height: 150.h,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name: ',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          famillylist.firstname + famillylist.lastname,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Gender : ',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      famillylist.gender,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone Num : ',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      famillylist.phone,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      // famillylistController.familysetup(
                      //     famillylist.id.toString(), context);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Msgthrow(
                                famillylist.id.toString(),
                              ));
                    },
                    child: Text(
                      'Add+',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[700],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Msgthrow extends StatefulWidget {
  var id;
  Msgthrow(this.id);
  @override
  _MsgthrowState createState() => _MsgthrowState(this.id);
}

class _MsgthrowState extends StateMVC<Msgthrow> {
  var id;
  FunctionController famillylistController = FunctionController();
  _MsgthrowState(this.id) : super(FunctionController());
  String rellation;
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Select your relation',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'Poppins'),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: rellation == null
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        'Select*',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF323232),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        rellation,
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Color(0xFF000000),
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
              isExpanded: true,
              iconSize: 30.h,
              // style: TextStyle(color: Colors.black),
              items: [
                'Father',
                'Mother',
                'Sister',
                'Brother',
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val)

                  // =>
                  //     _famillybloc.familyRelationSink.add(SelectFamilyRelation())

                  {
                setState(
                  () {
                    rellation = val;
                  },
                );
              },
            ),
          ),
        ),
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
            famillylistController.familysetup(
                id.toString(), rellation, context);
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
