import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/model/shedulelistmodel.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ShedulelistWeiget extends StatefulWidget {
  var shedule;
  var starttime;
  var endtime;
  ShedulelistWeiget({this.shedule, this.starttime, this.endtime});

  @override
  _ShedulelistWeigetState createState() =>
      _ShedulelistWeigetState(this.shedule, this.starttime, this.endtime);
}

class _ShedulelistWeigetState extends StateMVC<ShedulelistWeiget> {
  var shedule;
  var starttime;
  var endtime;

  // var start_time = jsonDecode(sheduleListModel.startTime);
  FunctionController shedulefunction = FunctionController();
  _ShedulelistWeigetState(this.shedule, this.starttime, this.endtime)
      : super(FunctionController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
//  height: MediaQuery.of(context).size.height * 0.068,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //E9F2F2
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: shedule.chambers != null
                              ? Text(
                                  'Chamber Name: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : Text(
                                  'Online Chamber ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                      Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: shedule.chambers != null
                              ? Text(
                                  shedule.chambers.chamberName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Day: ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        shedule.day,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      children: List.generate(starttime.length, (index) {
                    return Row(
                      children: <Widget>[
                        Text(
                          'Start Time : ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          DateFormat("h:mma").format(DateTime.parse(
                              "${starttime[index]['value'].toString()}")),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    );
                  })),
                  Column(
                      children: List.generate(endtime.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'End Time : ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          DateFormat("h:mma").format(DateTime.parse(
                              "${endtime[index]['value'].toString()}")),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    );
                  })),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'patient Limit : ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        shedule.patientLimit,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Interval Time : ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        shedule.intervalTime,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        // primary: Color(0xff31AF4E),
                        primary: Colors.white70,
                      ),
                      child: Icon(Icons.edit, size: 15, color: Colors.green)),
                  ElevatedButton(
                      onPressed: () {
                        shedulefunction.sheduleDelate(
                            shedule.id.toString(), 'chamber', context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white70,
                          textStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: Icon(Icons.delete, size: 15, color: Colors.red)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
