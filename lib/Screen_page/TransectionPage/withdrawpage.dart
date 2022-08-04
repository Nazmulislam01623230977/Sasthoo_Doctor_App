import 'package:doctot_sasthoo/model/withdrawmodel.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/withdrawlistweiget.dart';
import 'package:flutter/material.dart';

class WithdrwaList extends StatefulWidget {
  WithdrwaList({Key key}) : super(key: key);

  @override
  State<WithdrwaList> createState() => _WithdrwaListState();
}

class _WithdrwaListState extends State<WithdrwaList> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.trangeciton_page),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context)
                .popAndPushNamed(RouteManeger.trangeciton_page),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff31AF4E),
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            'Withdraw ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Color(0xFFFFFFFF),
            ),
          ),
          //
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: ListView.builder(
                itemCount: withdrawlist.length,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var withdraw = withdrawlist[index];
                  return WithdrawListWeiget(withdrawlist: withdraw);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
