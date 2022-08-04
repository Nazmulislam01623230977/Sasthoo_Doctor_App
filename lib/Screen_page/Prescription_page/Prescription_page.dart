// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:doctot_sasthoo/Screen_page/Prescription_page/PrescriptionPdf_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../../Componet/MainDrawer.dart';
import '../../api/apitoken.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../api/apiurl.dart';
import '../../model/patient_details_model.dart';

class Prescription_page extends StatefulWidget {
  PatientData patiendetails;
  Prescription_page(this.patiendetails);

  @override
  _Prescription_pageState createState() =>
      _Prescription_pageState(this.patiendetails);
}

class _Prescription_pageState extends State<Prescription_page> {
  var patientdetails;
  _Prescription_pageState(this.patientdetails);
  TextEditingController perdayController = TextEditingController();
  TextEditingController madicineDuration = TextEditingController();
  TextEditingController totalDorse = TextEditingController();
  TextEditingController problemcontorller = TextEditingController();

  List<bool> pic = [true, false];
  List<bool> mint = [true, false];
  List<bool> day = [true, false];
  int mealval = 1;
  String _medicinee;
  final maxLines = 5;
  // String _Mor;

  List _myActivities1;
  String _myActivitiesResults;
  final formKey1 = new GlobalKey<FormState>();

  List _myActivities;

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivities1 = [];
    getalltest();
  }

  _savesForm() {
    var form = formKey1.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResults = _myActivities1.toString();
      });
    }
  }

  List alltest;
  List allmadicine;
  Map<String, dynamic> madicineData;
  getalltest() async {
    var client = http.Client();
    var mainurl = ApiRepo.alltest;
    try {
      var url = Uri.parse(mainurl);
      var response = await client.get(
        url,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        setState(() {
          alltest = jsonMap['result'];
        });
      }
    } on Exception {
      alltest = [];
    }
  }

  List<Map<String, dynamic>> _madicinelist = [];

  addMadicine() {
    var mealvalue;
    var pices;
    var minite;
    var dayvalue;
    if (perdayController.text == "") {
      internaterror("Per day filled can't be blank ", context);
    } else if (_medicinee == "") {
      internaterror("Madicine filled can't be blank", context);
    } else if (madicineDuration.text == "") {
      internaterror("Badicine duration filled can't be blank", context);
    } else if (totalDorse.text == "") {
      internaterror("Total dorse filled can't be blank", context);
    } else {
      if (mealval == 1) {
        mealvalue = "before";
      } else if (mealval == 2) {
        mealvalue = "after";
      }

      // ignore: unrelated_type_equality_checks
      if (pic == true) {
        pices = "psc";
      } else {
        pices = "spoon";
      }

      // ignore: unrelated_type_equality_checks
      if (mint == true) {
        minite = "mint";
      } else {
        minite = "hrs";
      }

      // ignore: unrelated_type_equality_checks
      if (day == true) {
        dayvalue = "day";
      } else {
        dayvalue = "month";
      }

      madicineData = {
        "madicine_name": _medicinee,
        "madicine_perday": perdayController.text,
        "pic": pices,
        "madicine_duration": madicineDuration.text,
        "minite": minite,
        "total_dorse": totalDorse.text,
        "dayvalue": dayvalue,
        "meal_value": mealvalue,
        "meal_value": mealvalue,
      };
      _madicinelist.add(madicineData);

      setState(() {
        _madicinelist = _madicinelist;
      });

      perdayController.clear();
      madicineDuration.clear();
      totalDorse.clear();
      print(_madicinelist);
    }
  }

  removedmadicine(var removeMadicinedata) {
    _madicinelist.remove(removeMadicinedata);
    setState(() {
      _madicinelist = _madicinelist;
    });
  }

  void internaterror(String massge, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(massge),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(69.h),
          child: AppBar(
              leading: Builder(builder: (BuildContext context) {
                return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset('assets/images/menu.png'));
              }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(19.r),
                ),
              ),
              backgroundColor: Color(0xff128041),
              bottomOpacity: 0.0,
              elevation: 0.0,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Stack(
                    children: const [
                      Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      Positioned(
                        left: 10,
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.red,
                          size: 9,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.r,
                  ),
                ),
              ]),
        ),
        drawer: MainDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'Prescription',
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 2.h, bottom: 2.h),
                  child: Divider(
                    color: Color(0xff000000),
                    // color: Color(0xff959595),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Details',
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.patiendetails.patient.firstName +
                            " " +
                            widget.patiendetails.patient.lastName,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Date: ' + widget.patiendetails.patient.dateOfBirth,
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: formKey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(

                                // border: Border.all(
                                //   width: 1,
                                //   color: Colors.black54,
                                // ),
                                color: Color(0xffffffff), //E9F2F2
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            // padding: EdgeInsets.only(left: 8, top: 5, right: 8),
                            child: MultiSelectFormField(
                              border: InputBorder.none,
                              // autovalidate: false,
                              chipBackGroundColor: Colors.green,
                              chipLabelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              dialogTextStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              checkBoxActiveColor: Colors.green,
                              checkBoxCheckColor: Colors.white,
                              dialogShapeBorder: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12..r))),
                              title: Text(
                                "Select Test",
                                style: GoogleFonts.roboto(
                                    color: Color(0xff000000),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              dataSource: alltest,
                              textField: 'test_name',
                              valueField: 'test_name',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',

                              initialValue: _myActivities,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myActivities = value;
                                });
                                print(_myActivities);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Medicine                        :  ',
                        style: GoogleFonts.roboto(
                            color: Color(0xff000000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Container(
                        width: 225.w,
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: _medicinee == null
                                ? Text(
                                    'medicine',
                                    style: GoogleFonts.roboto(
                                        color: Color(0xff000000),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    _medicinee,
                                    style: GoogleFonts.roboto(
                                        color: Color(0xff000000),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                            isExpanded: true,
                            iconSize: 30.h,
                            style: GoogleFonts.roboto(
                                color: Color(0xff000000),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                            items: [
                              'Napa',
                              'Napa Extra',
                              'Seclo',
                              'Low sectine'
                            ].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _medicinee = val;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Medicine per day          :  ',
                        style: GoogleFonts.roboto(
                            color: Color(0xff000000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: TextField(
                          controller: perdayController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      ToggoleText(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Medicine duration        :  ',
                        style: GoogleFonts.roboto(
                            color: Color(0xff000000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: TextField(
                          controller: madicineDuration,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      ToggoleText2()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Total dose                     :',
                        style: GoogleFonts.roboto(
                            color: Color(0xff000000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: TextField(
                          controller: totalDorse,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      ToggoleText3(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: mealval,
                            onChanged: (value) {
                              setState(() {
                                mealval = value;
                                print(mealval);
                              });
                            },
                            activeColor: Colors.green,
                            toggleable: true,
                          ),
                          Text(
                            "Before Meal",
                            style: GoogleFonts.roboto(
                                color: Color(0xff000000),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 70.w,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: mealval,
                            onChanged: (value) {
                              setState(() {
                                mealval = value;
                                print(mealval);
                              });
                            },
                            activeColor: Colors.green,
                            toggleable: true,
                          ),
                          Text(
                            "After Meal",
                            style: GoogleFonts.roboto(
                                color: Color(0xff000000),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 40.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: Color(0xff128041), //E9F2F2
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: IconButton(
                          onPressed: () {
                            addMadicine();
                          },
                          icon: Text(
                            "Add",
                            style: GoogleFonts.roboto(
                                color: Color(0xffffffff),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _madicinelist.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _madicinelist[index]["madicine_name"]
                                    .toString(),
                                style: GoogleFonts.roboto(
                                    color: Color(0xff000000),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      removedmadicine(_madicinelist[index]);
                                    },
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, top: 2.h),
                            child: Row(
                              children: [
                                Text(
                                  "Per Day: " +
                                      _madicinelist[index]["madicine_perday"]
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  " " +
                                      _madicinelist[index]["pic"].toString() +
                                      " || ",
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Duration: " +
                                      _madicinelist[index]["madicine_duration"]
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _madicinelist[index]["minite"].toString() +
                                      " || ",
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Total dorse: " +
                                      _madicinelist[index]["total_dorse"]
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _madicinelist[index]["dayvalue"].toString() +
                                      " || ",
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _madicinelist[index]["meal_value"]
                                          .toString() +
                                      " Meal",
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff000000),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                      // return thurssheduleformwidget(index);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                    margin: EdgeInsets.only(
                        top: 20.h, bottom: 20.h, left: 16.w, right: 16.w),
                    height: maxLines * 24.0,
                    child: TextField(
                      controller: problemcontorller,
                      maxLines: maxLines,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "If any direction.",
                        hintStyle: GoogleFonts.roboto(
                            color: Color(0xff000000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                        // fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                      height: 52.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrescriptionPdf_page(
                                        _madicinelist,
                                        _myActivities,
                                        problemcontorller.text,
                                        widget.patiendetails.patient.firstName,
                                        widget.patiendetails.patient.lastName,
                                        widget.patiendetails.patient.id
                                            .toString(),
                                        widget
                                            .patiendetails.patient.dateOfBirth,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  Widget ToggoleText() => Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ToggleButtons(
          children: [
            Text(
              'Pcs.',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'spoon',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          isSelected: pic,
          fillColor: Color(0xffEEEEEE),
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < pic.length; index++) {
                if (index == newIndex) {
                  pic[index] = true;
                } else {
                  pic[index] = false;
                }
              }
            });
          },
        ),
      );
  Widget ToggoleText2() => Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ToggleButtons(
          children: [
            Text(
              'Mnt',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Hr',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          isSelected: mint,
          fillColor: Color(0xffEEEEEE),
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < mint.length; index++) {
                if (index == newIndex) {
                  mint[index] = true;
                } else {
                  mint[index] = false;
                }
              }
            });
          },
        ),
      );
  Widget ToggoleText3() => Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ToggleButtons(
          children: [
            Text(
              'Day',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Month',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          isSelected: day,
          fillColor: Color(0xffEEEEEE),
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < day.length; index++) {
                if (index == newIndex) {
                  day[index] = true;
                } else {
                  day[index] = false;
                }
              }
            });
          },
        ),
      );
}
