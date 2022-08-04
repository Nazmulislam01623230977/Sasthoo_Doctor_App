import 'dart:convert';

import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';
import '../../Controller/functionController.dart';
import '../../api/apiurl.dart';
import '../../model/patient_details_model.dart';
import '../../model/transaction_models.dart';
import '../../weiget/compeletetransweiget.dart';
import '../../weiget/pandingtransaction.dart';

class TransectionPage extends StatefulWidget {
  TransectionPage({Key key}) : super(key: key);

  @override
  State<TransectionPage> createState() => _TransectionPageState();
}

class _TransectionPageState extends State<TransectionPage> {
  List<Transcation> transaction;

  bool isLoaded = false;
  transactionfunction() async {
    transaction = await FunctionController().transaction();
    if (transaction != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  List<PatientData> patienData;

  patientgetdata() async {
    patienData = await FunctionController().patientDetatilsCont();
    if (patienData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  var photo;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
  }

  void initState() {
    transactionfunction();
    patientgetdata();
    this.userdataget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Scaffold(
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
            title: new Center(
                child: new Text('',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center)),
            centerTitle: true,
            backgroundColor: Color(0xff128041),
            bottomOpacity: 0.0,
            elevation: 0.0,
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
                onPressed: () {},
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
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Text(
                      'Transactions',
                      style: GoogleFonts.poppins(
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
                      thickness: 1.h,
                      // color: Color(0xff959595),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white38),
                      child: TabBar(
                          indicator: BoxDecoration(
                              color: Color(0xff128041),
                              borderRadius: BorderRadius.circular(8.r)),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                'Complete',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                'Panding',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.h,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 800.h,
                    child: TabBarView(children: [
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 5.h),
                            child: transaction != null
                                ? ListView.builder(
                                    itemCount: transaction.length,
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var transactionlist = transaction[index];
                                      return CompleteTransWeiget(
                                          complete: transactionlist);
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 5.h),
                            child: patienData != null
                                ? ListView.builder(
                                    itemCount: patienData.length,
                                    scrollDirection: Axis.vertical,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var paindingamount = patienData[index];
                                      return PandingTransaction(
                                          paindingamountt: paindingamount);
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
