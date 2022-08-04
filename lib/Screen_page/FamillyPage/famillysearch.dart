import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/model/familymodel.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/familyweiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../Componet/MainDrawer.dart';
import '../../weiget/familylistweiget.dart';

class Familysearch extends StatefulWidget {
  var familylistmodel;
  Familysearch(this.familylistmodel, {Key key}) : super(key: key);

  @override
  _FamilysearchState createState() => _FamilysearchState(this.familylistmodel);
}

class _FamilysearchState extends StateMVC<Familysearch> {
  var familylistmodel;
  FunctionController familylistController = FunctionController();
  _FamilysearchState(this.familylistmodel) : super(FunctionController());
  List data;
  List famailylista = [];
  familylistfineout(String phoneno, BuildContext context) {
    var url = ApiRepo.familylist + "$phoneno";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      if (res.statusCode == 200) {
        var massage = await res.stream.bytesToString();
        var data = jsonDecode(massage);
        setState(() {
          famailylista = (data['result'] as List)
              .map((e) => Familymodel.fromJSON(e))
              .toList();
        });
      }
    });
  }

  var userdatashow;

  var id;
  List familylistadd = [];
  var photo;
  // _FamilylistState(this.familylistmodel);
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    id = userdata['id'];
    setState(() {
      photo = userdata['photo'];
    });
  }

  familllistaddfunction() async {
    await userdataget();
    var url = ApiRepo.familylistadd + "${id}";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      this.setState(() {
        familylistadd = (jsonData['result'] as List)
            .map((e) => Familymodel.fromJSON(e))
            .toList();
      });
    });
  }

  void initState() {
    super.initState();
    familllistaddfunction();
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
                            radius: 18, // Image radius
                            backgroundImage: NetworkImage(
                              Baseurl.mainurl +
                                  "/${photo['avater'].toString()}",
                            ))
                        : const CircleAvatar(
                            radius: 18, // Image radius
                            backgroundImage: AssetImage(
                              'assets/fonts/images/noimage.png',
                            ),
                          )),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffffffff), //E9F2F2
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: TextField(
                      onChanged: (val) {
                        familylistfineout(val, context);
                      },
                      // controller: searchController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search Familly',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                  itemCount: famailylista.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var familly = famailylista[index];
                    return FamillyWeiget(familly: familly);
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text(
                    ' Family Member List',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 2.h, left: 20.w, right: 20.w),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    child: ListView.builder(
                      itemCount: familylistadd.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var familylist = familylistadd[index];
                        return Familylistweiget(familylistmodel: familylist);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
