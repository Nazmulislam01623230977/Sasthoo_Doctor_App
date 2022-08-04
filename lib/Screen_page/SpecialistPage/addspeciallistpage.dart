import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/speiallistweiget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componet/MainDrawer.dart';

class AddSpecilestPage extends StatefulWidget {
  AddSpecilestPage({Key key}) : super(key: key);

  @override
  _AddSpecilestPageState createState() => _AddSpecilestPageState();
}

class _AddSpecilestPageState extends StateMVC<AddSpecilestPage> {
  var userdatashow;
  var userid;
  List speciallistdata = [];
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    userid = userdata['id'];
  }

// ==========================
  speciallistlistfunction() async {
    await userdataget();
    var url = ApiRepo.speciallist + "$userid";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      setState(() {
        speciallistdata = jsonData['result'];
        print(speciallistdata);
      });
    });
  }

// =====================

  void initState() {
    super.initState();
    speciallistlistfunction();
    userdatagetdata();
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
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Specialist',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 2, left: 20, right: 10),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(RouteManeger.specialist_page);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff128041),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '+ Add Specialist ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff)),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
              child: speciallistdata.length > 0
                  ? ListView.builder(
                      itemCount: speciallistdata.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var speciest = json
                            .decode(speciallistdata[index]['sub_specialitie']);
                        var special = speciallistdata[index];
                        return SpeciallstWeiget(
                          dspecilestlist: special,
                          speciest: speciest,
                        );
                      },
                    )
                  : Center(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.redAccent,
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                        minHeight: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
