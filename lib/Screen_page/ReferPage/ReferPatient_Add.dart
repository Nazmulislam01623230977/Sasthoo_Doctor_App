import 'package:doctot_sasthoo/Screen_page/ReferPage/ReferPatient_page.dart';
import 'package:flutter/material.dart';
import '../../Componet/MainDrawer.dart';

class ReferPatientAdd extends StatefulWidget {
  const ReferPatientAdd({Key key}) : super(key: key);

  @override
  _ReferPatientAddState createState() => _ReferPatientAddState();
}

class _ReferPatientAddState extends State<ReferPatientAdd> {
  String _specialisttype;
  String _doctortype;
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Specialist",
                style: TextStyle(
                    color: Color(0xff596970),
                    fontSize: 12,
                    fontWeight: FontWeight.bold), //596970
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.068,
                alignment: Alignment.centerLeft,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: _specialisttype == null
                          ? Text(
                              'specialist',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              _specialisttype,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 25.0,
                      style: TextStyle(color: Colors.black),
                      items: ['A', 'B', 'C'].map(
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
                            _specialisttype = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5),
              child: Text(
                "Doctor Name",
                style: TextStyle(
                    color: Color(0xff596970),
                    fontSize: 12,
                    fontWeight: FontWeight.bold), //596970
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.068,
                alignment: Alignment.centerLeft,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: _doctortype == null
                          ? Text(
                              'doctor',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              _doctortype,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 25.0,
                      style: TextStyle(color: Colors.black),
                      items: ['dr shakib', 'dr', 'dr3'].map(
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
                            _doctortype = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
               padding: const EdgeInsets.only(left: 10, right: 10),
              child: buildReason(context),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: buildReferby(context),
            ),

            // Text(
            //   'Specialist :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Poppins',
            //     fontSize: 14,
            //   ),
            // ),

            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.only(left: 0, right: 16),
            //   decoration: BoxDecoration(
            //     //border: Border.all(color: Colors.red, width: 1),
            //     // borderRadius: BorderRadius.circular(5),
            //     border: Border(bottom: BorderSide()),
            //   ),
            //   child: DropdownButton(
            //     hint: _specialisttype == null
            //         ? Text(
            //             'specialist',
            //           )
            //         : Text(
            //             _specialisttype,
            //             style: TextStyle(color: Colors.black),
            //           ),
            //     isExpanded: true,
            //     iconSize: 30.0,
            //     style: TextStyle(color: Colors.black),
            //     items: ['A', 'B', 'C'].map(
            //       (val) {
            //         return DropdownMenuItem<String>(
            //           value: val,
            //           child: Text(val),
            //         );
            //       },
            //     ).toList(),
            //     onChanged: (val) {
            //       setState(
            //         () {
            //           _specialisttype = val;
            //         },
            //       );
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'Doctor :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Poppins',
            //     fontSize: 14,
            //   ),
            // ),
            // // SizedBox(
            // //   height: 2,
            // // ),
            // Container(
            //   width:double.infinity,
            //   padding: EdgeInsets.only(left: 0, right: 16),
            //   decoration: BoxDecoration(
            //     //border: Border.all(color: Colors.red, width: 1),
            //     // borderRadius: BorderRadius.circular(5),
            //     border: Border(bottom: BorderSide()),
            //   ),
            //   child: DropdownButton(
            //     hint: _doctortype == null
            //         ? Text(
            //             'Doctor',
            //           )
            //         : Text(
            //             _doctortype,
            //             style: TextStyle(color: Colors.black),
            //           ),
            //     isExpanded: true,
            //     iconSize: 30.0,
            //     style: TextStyle(color: Colors.black),
            //     items: ['d', 'e', 'f'].map(
            //       (val) {
            //         return DropdownMenuItem<String>(
            //           value: val,
            //           child: Text(val),
            //         );
            //       },
            //     ).toList(),
            //     onChanged: (val) {
            //       setState(
            //         () {
            //           _doctortype = val;
            //         },
            //       );
            //     },
            //   ),
            // ),

            // Text(
            //   'Reason :',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Poppins',
            //     fontSize: 14,
            //   ),
            // ),

            // Container(
            //   width: double.infinity,
            //   child: TextFormField(
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       hintText: 'Reason ',
            //       hintStyle: TextStyle(
            //         //fontWeight: FontWeight.bold,
            //         fontSize: 12,
            //         //color: Colors.black,
            //         fontFamily: 'Poppins',
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  height: 30,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReferPatient_page()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff31AF4E),
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    child: Text('Submit'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildReason(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Reason",
        style: TextStyle(
            color: Color(0xff596970),
            fontSize: 12,
            fontWeight: FontWeight.bold), //596970
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.068,
        alignment: Alignment.centerLeft,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            //controller: emailController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.replay_5_outlined,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'brother',
                hintStyle: TextStyle(
                    fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
          ),
        ),
      ),
    ],
  );
}

Widget buildReferby(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Refer By",
        style: TextStyle(
            color: Color(0xff596970),
            fontSize: 12,
            fontWeight: FontWeight.bold), //596970
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.068,
        alignment: Alignment.centerLeft,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            //controller: emailController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.replay_5_outlined,
                //   color: Color(0xffA7ADBC),
                // ),
                hintText: 'brother',
                hintStyle: TextStyle(
                    fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
          ),
        ),
      ),
    ],
  );
}
