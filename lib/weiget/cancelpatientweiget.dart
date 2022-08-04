import 'package:doctot_sasthoo/model/cancelpatientmodel.dart';
import 'package:flutter/material.dart';

class CancelpatientWeiget extends StatelessWidget {
  final Cancelpatientlist cancelpatientlist;
  const CancelpatientWeiget({Key key, this.cancelpatientlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 5),
                child: Text(
                  cancelpatientlist.text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 5),
                child: Text(
                  cancelpatientlist.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: cancelpatientlist.tk > 0
                  ? Text(
                      cancelpatientlist.tk.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    )
                  : Text(
                      cancelpatientlist.tk.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ))
        ],
      ),
    );
  }
}
