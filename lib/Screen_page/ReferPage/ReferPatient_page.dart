import 'package:doctot_sasthoo/Screen_page/ReferPage/ReferPatient_Add.dart';
import 'package:doctot_sasthoo/model/referpatientmodel.dart';
import 'package:doctot_sasthoo/weiget/referlistweiget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Componet/MainDrawer.dart';

class ReferPatient_page extends StatefulWidget {
  const ReferPatient_page({Key key}) : super(key: key);

  @override
  _ReferPatient_pageState createState() => _ReferPatient_pageState();
}

class _ReferPatient_pageState extends State<ReferPatient_page> {
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
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Refer Patient List',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 2, left: 20, right: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReferPatientAdd()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff128041),
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Refer patient'),
                            // Icon(Icons.add),
                          ],
                        ))),
                ListView.builder(
                  itemCount: referList.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var refer = referList[index];
                    return ReferListWeiget(referlist: refer);
                  },
                ),
              ]),
          // Container(
          //   padding: EdgeInsets.only(left: 16, right: 16),
          //   height: 100,
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //           //side: BorderSide(color: Colors.white70, width: 1),
          //           borderRadius: BorderRadius.circular(10),
          //              ),
          //     child: ListView(
          //       children: [
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10, top: 5),
          //               child: Text(
          //                 'Patient Name: Naeem Islam',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 12,
          //                   color: Colors.black,
          //                   fontFamily: 'Poppins',
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10),
          //               child: Text(
          //                 'Doctor Name: Islam',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 12,
          //                   color: Colors.black,
          //                   fontFamily: 'Poppins',
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10),
          //               child: Text(
          //                 'Refer By: Nazmul Islam',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 12,
          //                   color: Colors.black,
          //                   fontFamily: 'Poppins',
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10),
          //               child: Text(
          //                 'Reason : bou more gece',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 12,
          //                   color: Colors.black,
          //                   fontFamily: 'Poppins',
          //                 ),
          //               ),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ),
      ),
    );
  }
}
