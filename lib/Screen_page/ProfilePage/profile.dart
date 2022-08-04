import 'dart:convert';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/genarelinformation.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:doctot_sasthoo/weiget/educationexp.dart';
import 'package:doctot_sasthoo/weiget/workingexpweiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componet/MainDrawer.dart';
import '../../model/onlineprofilesheduile.dart';
import '../../model/profileShediule.dart';
import '../../model/speciality_model.dart';
import '../../weiget/chamberaddressweiget.dart';
import '../../weiget/onlinechamberweget.dart';
import '../../weiget/speiallistweiget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC<ProfilePage> {
  FunctionController _imageController;
  _ProfilePageState() : super(FunctionController()) {
    _imageController = controller as FunctionController;
  }
  bool isvisible = false;
  bool isvisible1 = false;
  bool isvisible2 = false;
  bool isvisible3 = false;
  bool isvisible5 = false;
  bool isvisible6 = false;
  bool isvisibleone = false;
  List education = [];
  List workingexpdata = [];
  var userdatashowdecode;
  var userdatashow;
  var photo;
  var userid;
  List<ProfilesheduleList> profileshedulelist;
  List<ProfileonlinesheduleList> onlineprofileshedulelist;

  List<Speicality> speciallistdataa;
  bool isLoaded = false;
  shedulelistfunction() async {
    profileshedulelist = await FunctionController().profleshedulelist();
    if (profileshedulelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  onlineshedulelistfunction() async {
    onlineprofileshedulelist =
        await FunctionController().onlineprofleshedulelist();
    if (onlineprofileshedulelist != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    userid = userdata['id'];
  }

// ==========================
  speciallistlistfunction() async {
    speciallistdataa = await FunctionController().specialitylist();
    if (speciallistdataa != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userdatashoww();
    shedulelistfunction();
    workingexpfunction();
    educationexpfunction();
    onlineshedulelistfunction();
    speciallistlistfunction();
  }

  userdatashoww() async {
    await userdataget();
    setState(() {
      userdatashowdecode = jsonDecode(userdatashow);
      photo = userdatashowdecode['photo'];
    });
  }

// ===================================
  educationexpfunction() async {
    await userdataget();
    var decodedata = jsonDecode(userdatashow);
    userid = decodedata['id'];
    var url = ApiRepo.educationexpurl + "${userid}";
    var apiurl = Uri.parse(url);

    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      setState(() {
        education = jsonData['result'];
      });
    });
  }

// ===========================
// ==========================
  workingexpfunction() async {
    await userdataget();
    var decodedata = jsonDecode(userdatashow);
    userid = decodedata['id'];
    var url = ApiRepo.workingexpurl + "${userid}";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      setState(() {
        workingexpdata = jsonData['result'];
        // print(workingexpdata);
      });
    });
  }

  File profilepic;
  final picker = ImagePicker();
  Future<File> file;
  void getImage(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    profilepic = File(pickedFile.path);
    _imageController.imagereuest(profilepic, context);
  }

// =====================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page),
      child: Scaffold(
        appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset('assets/images/menu.png'));
            }),
            backgroundColor: Color(0xff128041),
            bottomOpacity: 0.0,
            elevation: 0.0,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenarelInformation(widget)),
                    );
                  },
                  child: Image.asset(
                    "assets/images/edit.png",
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ]),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff128041),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(19.r),
                        bottomRight: Radius.circular(19.r),
                      )),
                  height: 150.h,
                  // height: MediaQuery.of(context).size.height * .16,
                  width: 428.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          getImage(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                      width: 75.h,
                                      height: 75.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                offset: Offset(0, 10))
                                          ],
                                          shape: BoxShape.circle,
                                          image: photo != null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    Baseurl.mainurl +
                                                        "/${photo['avater'].toString()}",
                                                  ))
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/noimage.png',
                                                  )))),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${userdatashowdecode['title'].toString()}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${userdatashowdecode['first_name'].toString()}" +
                                          " " +
                                          "${userdatashowdecode['last_name'].toString()}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                speciallistdataa != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            speciallistdataa.length, (index) {
                                          return Text(
                                            "Speciality: " +
                                                speciallistdataa[index]
                                                    .specialitie,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }))
                                    : Center(
                                        child: Text(""),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Container(
                  height: 50.h,
                  width: 388.w,
                  decoration: BoxDecoration(
                      color: Color(0xFF128041), //E9F2F2
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Online',
                            style: GoogleFonts.poppins(
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible5 = !isvisible5;
                              });
                            },
                            icon: isvisible5 == false
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    size: 25.h,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    size: 25.h,
                                    color: Colors.white,
                                  ))
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: isvisible5,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: onlineprofileshedulelist != null
                        ? ListView.builder(
                            itemCount: onlineprofileshedulelist.length,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var sedule = onlineprofileshedulelist[index];
                              var start = jsonDecode(sedule.startTime);
                              var endt = jsonDecode(sedule.endTime);
                              return OnlineChamberShedule(
                                  onlinechamber: sedule,
                                  starttime: start,
                                  endtime: endt);
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),

                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () {
                    isvisible = !isvisible;
                  },
                  child: Container(
                    height: 50.h,
                    width: 388.w,
                    decoration: BoxDecoration(
                        color: Color(0xff128041), //E9F2F2
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Offline chamber',
                              style: GoogleFonts.poppins(
                                color: Color(0xFFffffff),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                              icon: isvisible == false
                                  ? Icon(
                                      Icons.arrow_drop_down,
                                      size: 25.h,
                                      color: Color(0xFFffffff),
                                    )
                                  : Icon(
                                      Icons.arrow_drop_up,
                                      size: 25.h,
                                      color: Color(0xFFffffff),
                                    )),
                        ],
                      ),
                    ),
                  ),
                ),
                // Visibility(visible: isvisible, child: chamberonline()),
                SizedBox(
                  height: 5.h,
                ),
                Visibility(
                    visible: isvisible,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      child: profileshedulelist != null
                          ? ListView.builder(
                              itemCount: profileshedulelist.length,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var staff = profileshedulelist[index];
                                return Chamberaddressweiget(
                                    chamberaddress: staff);
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    )),

                Container(
                  height: 50.h,
                  width: 388.w,
                  decoration: BoxDecoration(
                      color: Color(0xff128041), //E9F2F2
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Personal Information',
                            style: GoogleFonts.poppins(
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible1 = !isvisible1;
                              });
                            },
                            icon: isvisible1 == false
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    size: 25.h,
                                    color: Color(0xFFFfFFFf),
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    size: 25.h,
                                    color: Color(0xFFFfFFFf),
                                  )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isvisible1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                    child: Card(
                      color: Color(0xFFFfFFFf),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title: ${userdatashowdecode['title'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "Name:${userdatashowdecode['first_name'].toString()}" +
                                        " " +
                                        "${userdatashowdecode['last_name'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone Number: ${userdatashowdecode['phone'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "Gender:${userdatashowdecode['gender'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Passport Number: ${userdatashowdecode['passport'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "BMDC No:${userdatashowdecode['bmdc_no'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NID:${userdatashowdecode['nid'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    "Email: ${userdatashowdecode['email'].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GenarelInformation(widget)),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit_note,
                                    color: Color(0xFF128041),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Container(
                          height: 50.h,
                          width: 388.w,
                          decoration: BoxDecoration(
                              color: Color(0xff128041), //E9F2F2
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Specialist',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFFffffff),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisible6 = !isvisible6;
                                      });
                                    },
                                    icon: isvisible6 == false
                                        ? Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                            size: 25.h,
                                          )
                                        : Icon(
                                            Icons.arrow_drop_up,
                                            color: Colors.white,
                                            size: 25.h,
                                          ))
                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible: isvisible6,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 5.h, top: 5.h),
                        child: speciallistdataa != null &&
                                speciallistdataa.length > 0
                            ? ListView.builder(
                                itemCount: speciallistdataa.length,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var special = speciallistdataa[index];
                                  var speciest =
                                      jsonDecode(special.subSpecialitie);
                                  return SpeciallstWeiget(
                                    dspecilestlist: special,
                                    speciest: speciest,
                                  );
                                },
                              )
                            : IconButton(
                                onPressed: () {
                                  Navigator.of(context).popAndPushNamed(
                                      RouteManeger.specialist_page);
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Color(0xFF13A30E),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),

                Column(
                  children: [
                    Container(
                      height: 50.h,
                      width: 388.w,
                      decoration: BoxDecoration(
                          color: Color(0xff128041), //E9F2F2
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Education background',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFffffff),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisible2 = !isvisible2;
                                  });
                                },
                                icon: isvisible2 == false
                                    ? Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                        size: 25.h,
                                      )
                                    : Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                        size: 25.h,
                                      ))
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isvisible2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 5.h, top: 5.h),
                        child: Column(
                          children: [
                            education.length > 0
                                ? ListView.builder(
                                    itemCount: education.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var educationex = education[index];
                                      return EducationView(
                                          education: educationex);
                                    },
                                  )
                                : IconButton(
                                    onPressed: () {
                                      Navigator.of(context).popAndPushNamed(
                                          RouteManeger.working_page);
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Color(0xFF13A30E),
                                      size: 25.h,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50.h,
                        width: 388.w,
                        decoration: BoxDecoration(
                            color: Color(0xff128041), //E9F2F2
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40.w, top: 5.h, bottom: 5.h, right: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Working  Experience',
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFFfFFFf),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isvisible3 = !isvisible3;
                                    });
                                  },
                                  icon: isvisible3 == false
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                          size: 25.h,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.white,
                                          size: 25.h,
                                        ))
                            ],
                          ),
                        )),
                  ],
                ),
                Visibility(
                  visible: isvisible3,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, bottom: 5.h, top: 5.w),
                    child: workingexpdata.length > 0
                        ? ListView.builder(
                            itemCount: workingexpdata.length,
                            scrollDirection: Axis.vertical,
                            // physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var workingexpp = workingexpdata[index];
                              return WorkingexpView(workingexp: workingexpp);
                            },
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed(RouteManeger.education_page);
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Color(0xFF13A30E),
                              size: 25.h,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
