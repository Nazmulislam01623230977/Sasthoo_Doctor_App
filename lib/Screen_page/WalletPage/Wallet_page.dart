import 'dart:convert';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/WalletPage/WalletSetup_page.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/model/total_amount.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/walletlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componet/MainDrawer.dart';

// ignore: camel_case_types
class Wallet_page extends StatefulWidget {
  const Wallet_page({Key key}) : super(key: key);

  @override
  _Wallet_pageState createState() => _Wallet_pageState();
}

// ignore: camel_case_types
class _Wallet_pageState extends State<Wallet_page> {
  var userdatashow;
  var id;
  List walletlist = [];
  var photo;
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    id = userdata['id'];
    setState(() {
      photo = userdata['photo'];
    });
  }

  walletlistfunction() async {
    await userdataget();
    var url = ApiRepo.walletlist + "${id}";
    print(url);
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      // print(jsonData);
      this.setState(() {
        walletlist = jsonData['result'];
        print(walletlist);
      });
    });
  }

  TotalAmount totalamount;
  bool isload = false;
  currentBlanch() async {
    totalamount = await FunctionController().totalamountfunction();
    if (totalamount != null) {
      setState(() {
        isload = true;
      });
    }
  }

  void initState() {
    super.initState();
    walletlistfunction();
    currentBlanch();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Scaffold(
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
                            radius: 18.r, // Image radius
                            backgroundImage: NetworkImage(
                              Baseurl.mainurl +
                                  "/${photo['avater'].toString()}",
                            ))
                        :  CircleAvatar(
                            radius: 18.r, // Image radius
                            backgroundImage: AssetImage(
                              'assets/fonts/images/noimage.png',
                            ),
                          )),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: Scaffold(
          backgroundColor: Color(0xffffffff),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    'My Wallet',
                    style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                  child: Divider(
                    color: Color(0xff000000),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Container(
                    height: 120.h,
                    width: double.infinity,
                    color: Color(0xff128041),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: totalamount != null
                                ? Text(
                                    '৳' + totalamount.data.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text("")),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Total Balance',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: Color(0xff01BE4D),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 52.h,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletSetup_page()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff128041),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '+ Add Wallet',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffffffff)),
                            ),
                          ],
                        ),
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.h, left: 20.w, right: 20.w, bottom: 5.h),
                      child: walletlist.length > 0
                          ? ListView.builder(
                              itemCount: walletlist.length,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var wallet = walletlist[index];
                                return Walletlistmodel(walletlist: wallet);
                              },
                            )
                          : Center(child: Text(''))),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
