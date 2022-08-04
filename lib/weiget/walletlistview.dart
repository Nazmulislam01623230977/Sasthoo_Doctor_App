import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/WalletPage/walletedit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class Walletlistmodel extends StatefulWidget {
  var walletlist;
  Walletlistmodel({Key key, this.walletlist}) : super(key: key);

  @override
  _WalletlistmodelState createState() => _WalletlistmodelState(this.walletlist);
}

class _WalletlistmodelState extends StateMVC<Walletlistmodel> {
  var walletlist;
  FunctionController walletController = FunctionController();
  _WalletlistmodelState(this.walletlist) : super(FunctionController());

  // _WalletlistmodelState(this.walletlist);
  @override
  void initState() {
    super.initState();
    // walletdelete();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        height: 155.h,
        decoration: BoxDecoration(
            color: Color(0xffffffff), //E9F2F2
            borderRadius: BorderRadius.circular(2.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.w, bottom: 10.h, right: 20.w, top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 6.h),
                    child: Row(
                      children: [
                        Text(
                          'Account type :',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.walletlist['account_type'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 3.h),
                    child: Row(
                      children: [
                        Text(
                          'Account number :',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.walletlist['account_no'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 3.h),
                    child: Row(
                      children: [
                        Text(
                          'Account Name :',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.walletlist['account_name'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 3.h),
                    child: Row(
                      children: [
                        Text(
                          'Bank Name:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.walletlist['bank_name'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 3.h),
                    child: Row(
                      children: [
                        Text(
                          'Branch Name :',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.walletlist['branch_name']
                              .toString(), //branch_name
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WalletEditPage(walletlist)));
                      // Navigator.of(context)
                      //     .popAndPushNamed(RouteManeger.walletedit_page);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Color(0xffffffff),
                      // primary: Color(0xff31AF4E),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => msgthrow(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color(0xffffffff),
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget msgthrow(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Are you sure? You want to delete',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'Poppins'),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text("No"),
        ),
        new FlatButton(
          onPressed: () {
            walletController.walletdelete(walletlist['id'].toString(), context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.green[200])),
          textColor: Colors.black,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
