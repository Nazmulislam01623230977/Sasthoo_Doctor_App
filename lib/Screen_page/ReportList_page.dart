import 'package:doctot_sasthoo/model/reportlistmodel.dart';
import 'package:doctot_sasthoo/weiget/reportlistwieget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Componet/MainDrawer.dart';

class Reportlist_page extends StatefulWidget {
  const Reportlist_page({Key key}) : super(key: key);

  @override
  _Reportlist_pageState createState() => _Reportlist_pageState();
}

class _Reportlist_pageState extends State<Reportlist_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(69.0),
        child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(19),
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
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  // child: Image.asset(
                  //   "assets/images/logo.png",
                  //   height: 80,
                  //   width: 80,
                  // ),
                ),
              ),
            ]),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'List of Patient Report',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Divider(color: Color(0xff959595)),
            ),
            ListView.builder(
              itemCount: reportlist.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var appoinment = reportlist[index];
                return ReportListWeiget(reportlist: appoinment);
              },
            ),
          ],
        ),
      ),
    );
  }
}
