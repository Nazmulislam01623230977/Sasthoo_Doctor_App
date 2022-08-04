import 'dart:convert';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/model/familymodel.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/familylistweiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componet/MainDrawer.dart';

// ignore: must_be_immutable
class Familylist extends StatefulWidget {
  var familylistmodel;
  Familylist(this.familylistmodel);

  @override
  State<Familylist> createState() => _FamilylistState(this.familylistmodel);
}

class _FamilylistState extends State<Familylist> {
  var userdatashow;
  var familylistmodel;
  var id;
  List familylistadd = [];

  _FamilylistState(this.familylistmodel);
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    id = userdata['id'];
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
    this.userdatagetdata();
  }

  var photo;
  userdatagetdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    setState(() {
      photo = userdata['photo'];
    });
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(19.r),
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
                        left: 10,
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
              ]),
        ),
        drawer: MainDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
