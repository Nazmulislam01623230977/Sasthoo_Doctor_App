import 'package:doctot_sasthoo/model/withdrawmodel.dart';
import 'package:flutter/material.dart';

class WithdrawListWeiget extends StatelessWidget {
  final Withdrawlist withdrawlist;
  const WithdrawListWeiget({Key key, this.withdrawlist}) : super(key: key);

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
                  withdrawlist.text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 5),
                child: Text(
                  withdrawlist.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              withdrawlist.tk,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.green,
                // color: Color(0xFFFFFFFF),
              ),
            ),
          )
        ],
      ),
    );
  }
}
