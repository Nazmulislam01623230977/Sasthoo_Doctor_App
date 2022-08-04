import 'package:doctot_sasthoo/model/onlinepatientmodel.dart';
import 'package:flutter/material.dart';

class PatientWeiget extends StatelessWidget {
  final Onlinepatient onlinepatient;
  const PatientWeiget({Key key, this.onlinepatient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      child: Card(
        color: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: EdgeInsets.all(20.0),
        child: Container(
          child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(height: 20,width: 20,color: Color(0xFFA8A1A1),
            child: Text(onlinepatient.image),
            ),
            
            Column(
              children: [
                Text(onlinepatient.name,style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Poppins',
                               fontSize: 16,
                               color: Color(0xFF000000),
                             ),),
                              Spacer(),
                              Text(onlinepatient.problem,style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Poppins',
                               fontSize: 12,
                               color: Color(0xFF19D38C),
                             ),),
              ],
            ),
                         
            Column(children: [
              Text(onlinepatient.age,style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontFamily: 'Poppins',
                           fontSize: 12,
                           color: Color(0xFF000000),
                         ),),
                         Spacer(),
                          Text(onlinepatient.go,style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Poppins',
                               fontSize: 16,
                               color: Color(0xFF117E54),
                             ),),
            ],)
          ],),
        ),
      ),
    );
  }
}
