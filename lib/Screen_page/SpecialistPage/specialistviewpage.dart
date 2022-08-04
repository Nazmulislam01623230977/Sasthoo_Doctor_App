import 'dart:convert';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../route/route.dart';

class SpecialistViewpage extends StatefulWidget {
  SpecialistViewpage({
    Key key,
  }) : super(key: key);

  @override
  _SpecialistViewpageState createState() => _SpecialistViewpageState();
}

class _SpecialistViewpageState extends StateMVC<SpecialistViewpage> {
  FunctionController specielstController = FunctionController();
  _SpecialistViewpageState() : super(FunctionController());
  var spcilestvalue;
  String specialistName;
  List specialistlist = [];
  List myActivities;
  List subspecialistlist;
  final formKey = new GlobalKey<FormState>();

  speciallistfunction(String specialistName, BuildContext context) {
    print(specialistName);
    var url = ApiRepo.spceil;
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data["result"];
        setState(() {
          specialistlist = msg;
        });
      }
    });
  }

//
  subspeciallistfunction(BuildContext context) {
    var url = ApiRepo.subspceil + "$specialistName";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        var msg = data["result"];
        // print(msg);
        setState(() {
          subspecialistlist = msg;
        });
        print(subspecialistlist);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    speciallistfunction(specialistName, context);
    userdatagetdata();
  }

  var photo;
  userdatagetdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .popAndPushNamed(RouteManeger.profile_page);
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: photo != null
                        ? CircleAvatar(
                            radius: 18, // Image radius
                            backgroundImage: NetworkImage(
                              Baseurl.mainurl +
                                  "/${photo['avater'].toString()}",
                            ))
                        : const CircleAvatar(
                            radius: 18, // Image radius
                            backgroundImage: AssetImage(
                              'assets/fonts/images/noimage.png',
                            ),
                          )),
              ),
            ]),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
                child: Text(
                  "Specialist",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
              child: Container(
                height: 52.h,
                // height: MediaQuery.of(context).size.height * 0.068,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: specialistName == null
                          ? Text(
                              'Specialist',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w600,
                              ), //
                            )
                          : Text(
                              specialistName,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFF323232),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      isExpanded: true,
                      iconSize: 30.h,
                      style: TextStyle(color: Colors.black),
                      items: specialistlist.map(
                        (list) {
                          return DropdownMenuItem<String>(
                            value: list['specialitie'],
                            child: Text(list['specialitie']),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          specialistName = val;
                        });
                        subspeciallistfunction(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: MultiSelectFormField(
                          border: InputBorder.none,
                          chipBackGroundColor: Colors.green[300],
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.green,
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          title: Text(
                            "Sub Specialist",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Color(0xFF323232),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dataSource: subspecialistlist,
                          textField: 'sub_specialitie',
                          valueField: 'sub_specialitie',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: Text(
                            'Please seclected your sub Specialist',
                          ),
                          initialValue: myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              myActivities = value;
                            });
                          },
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Container(
                height: 52.h,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (specialistName == "") {
                        internaterror(" Filled can't be blank ", context);
                      } else if (myActivities == null) {
                        internaterror(" Filled can't be blank ", context);
                      } else {
                        // speciallistfunction(specialistName, context);
                        specielstController.speciallistsave(
                          specialistName,
                          myActivities,
                          context,
                        );
                        print(myActivities);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff128041),
                        padding: EdgeInsets.all(8),
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
