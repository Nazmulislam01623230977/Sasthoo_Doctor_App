import 'dart:convert';
import 'package:doctot_sasthoo/Controller/functionController.dart';
import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctot_sasthoo/api/apiurl.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Componet/MainDrawer.dart';

class NewSchedulePage extends StatefulWidget {
  const NewSchedulePage({Key key}) : super(key: key);

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends StateMVC<NewSchedulePage> {
  FunctionController sheduleController = FunctionController();
  _NewSchedulePageState() : super(FunctionController());

  TextEditingController patientlimitcontroller = TextEditingController();
  TextEditingController intervalTimecontroller = TextEditingController();

  bool isvisible20 = false;
  List onlinestatus = ['Online', 'Offline'];
  List emergencylist = ['Emergency', 'Normal'];
  String _onlinestatus;
  var userdatashow;
  var userid;
  int _count;
  int _moncount;
  int _tuecount;
  int _wedcount;
  int _thurscount;
  int _fricount;
  int _saturcount;
  List<Map<String, dynamic>> _sundaystartvalues;

  var _sundaystartjsonvalu;
  var _sundayendjsonvalu;
  var _mondaystartjsonvalu;
  var _mondayendjsonvalu;
  var _tuesdaystartjsonvalu;
  var _tuesdayendjsonvalu;

  var _wednesdaystartjsonvalu;
  var _wednesdayendjsonvalu;

  var _thursdaystartjsonvalu;
  var _thursdayendjsonvalu;
  var _fridaystartjsonvalu;
  var _fridayendjsonvalu;
  var _saturdaystartjsonvalu;
  var _saturdayendjsonvalu;

  bool su = false;
  bool mo = false;
  bool tu = false;
  bool wed = false;
  bool th = false;
  bool fr = false;
  bool sa = false;

  String _chamber;

  String _sunstartampm = "Am";
  String _sunendampm = "Am";
  String _monstartampm = "Am";
  String _monendampm = "Am";
  String _tuesstartampm = "Am";
  String _tuesendampm = "Am";
  String _wednesstartampm = "Am";
  String _wednesendampm = "Am";
  String _thursstartampm = "Am";
  String _thursendampm = "Am";
  String _fridstartampm = "Am";
  String _fridendampm = "Am";
  String _satstartampm = "Am";
  String _satendampm = "Am";

  var sundaystarttime;
  var sundayendtime;
  List chamberlist = [];
  userdataget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdatashow = sharedPreferences.getString('userdata');
    var userdata = jsonDecode(userdatashow);
    userid = userdata['id'];
  }

// ==========================
  chamberlistfunction() async {
    await userdataget();
    var url = ApiRepo.chamberlist + "${userid}";
    var apiurl = Uri.parse(url);
    var requestrespons = http.MultipartRequest(
      "GET",
      apiurl,
    );
    requestrespons.send().then((res) async {
      var massage = await res.stream.bytesToString();
      var jsonData = jsonDecode(massage);
      if (_onlinestatus != "Online") {
        setState(() {
          chamberlist = jsonData['result'];
        });
      } else {
        setState(() {
          chamberlist = [];
        });
      }
    });
  }

// =====================

  _sundayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _sunstartampm,
    };
    _sundaystartvalues.add(json);
    _sundaystartjsonvalu = jsonEncode(_sundaystartvalues);
    print(_sundaystartjsonvalu);
  }

  _sundayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _sunendampm,
    };
    _sundaystartvalues.add(json);
    _sundayendjsonvalu = jsonEncode(_sundaystartvalues);
    print(_sundayendjsonvalu);
  }

  // ===========================

  // =====================

  _mondayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _monstartampm,
    };
    _sundaystartvalues.add(json);
    _mondaystartjsonvalu = jsonEncode(_sundaystartvalues);
    print(_mondaystartjsonvalu);
  }

  _mondayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _monendampm,
    };
    _sundaystartvalues.add(json);
    _mondayendjsonvalu = jsonEncode(_sundaystartvalues);
    print(_mondayendjsonvalu);
  }

  // ===========================

  // =====================

  _tuesdayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _monstartampm,
    };
    _sundaystartvalues.add(json);
    _tuesdaystartjsonvalu = jsonEncode(_sundaystartvalues);
    print(_tuesdaystartjsonvalu);
  }

  _tuesdayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _monendampm,
    };
    _sundaystartvalues.add(json);
    _tuesdayendjsonvalu = jsonEncode(_sundaystartvalues);
    print(_tuesdayendjsonvalu);
  }

  // ===========================

  _wednesdayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _wednesstartampm,
    };
    _sundaystartvalues.add(json);
    setState(() {
      _wednesdaystartjsonvalu = jsonEncode(_sundaystartvalues);
    });

    print(_wednesdaystartjsonvalu);
  }

  _wednesdayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _wednesendampm,
    };
    _sundaystartvalues.add(json);
    setState(() {
      _wednesdayendjsonvalu = jsonEncode(_sundaystartvalues);
    });

    print(_wednesdayendjsonvalu);
  }
  // ========================
  // ===========================

  _thursdayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _thursstartampm,
    };
    _sundaystartvalues.add(json);
    setState(() {
      _thursdaystartjsonvalu = jsonEncode(_sundaystartvalues);
    });
  }

  _thursdayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _thursendampm,
    };
    _sundaystartvalues.add(json);
    setState(() {
      _thursdayendjsonvalu = jsonEncode(_sundaystartvalues);
    });

    print(_thursdayendjsonvalu);
  }
  // ========================
  // ===========================

  _fridayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _fridstartampm,
    };
    _sundaystartvalues.add(json);
    _fridaystartjsonvalu = jsonEncode(_sundaystartvalues);
    print(_fridaystartjsonvalu);
  }

  fridayEnTime(
    int index,
    String val,
  ) async {
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _fridendampm,
    };
    _sundaystartvalues.add(json);
    _fridayendjsonvalu = jsonEncode(_sundaystartvalues);
    print(_fridayendjsonvalu);
  }
  // ========================
  // ===========================

  _saturdayStarTime(
    int index,
    String val,
  ) async {
    print(index);
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _satstartampm,
    };
    _sundaystartvalues.add(json);
    _saturdaystartjsonvalu = jsonEncode(_sundaystartvalues);
    print(_saturdaystartjsonvalu);
  }

  saturdayEnTime(
    int index,
    String val,
  ) async {
    print(val);
    int foundKey = -1;
    for (var map in _sundaystartvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _sundaystartvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
      "ampm": _satendampm,
    };
    _sundaystartvalues.add(json);
    _saturdayendjsonvalu = jsonEncode(_sundaystartvalues);
    print(_saturdayendjsonvalu);
  }
  // ========================

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;

  bool isVisible = true;
  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isVisible3 = true;
  bool isVisible4 = true;
  bool isVisible5 = true;
  bool isVisible6 = true;

  TimeOfDay picked;
  TimeOfDay time;
  TimeOfDay time1;
  //TimeOfDay picked;
  @override
  void initState() {
    super.initState();
    this.userdatagetphoto();
    time = TimeOfDay.now();
    time1 = TimeOfDay.now();
    _count = 1;
    _sundaystartvalues = [];
    _moncount = 1;
    _tuecount = 1;
    _wedcount = 1;
    _thurscount = 1;
    _fricount = 1;
    _saturcount = 1;
    selectedsaturdayTime;
    selectedsaturdayTendime;

    // _sundayendvalues = [];
  }

// ============================= saturday==================================
  TimeOfDay selectedsaturdayTime = TimeOfDay.now();
  TimeOfDay selectedsaturdayTendime = TimeOfDay.now();
  _selectsaturdayEnTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedsaturdayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedsaturdayTime) {
      setState(() {
        selectedsaturdayTime = timeOfDay;
      });

      var selectdate = selectedsaturdayTime.hour;
      var selectminitue = selectedsaturdayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        saturdayEnTime(0,
            "0000-00-00 0${selectedsaturdayTime.hour}:0${selectedsaturdayTime.minute}:00");
      } else if (selectminitue < 9) {
        saturdayEnTime(0,
            "0000-00-00 ${selectedsaturdayTime.hour}:0${selectedsaturdayTime.minute}:00");
      } else if (selectdate < 9) {
        saturdayEnTime(0,
            "0000-00-00 0${selectedsaturdayTime.hour}:${selectedsaturdayTime.minute}:00");
      } else if (selectdate > 9) {
        saturdayEnTime(0,
            "0000-00-00 ${selectedsaturdayTime.hour}:${selectedsaturdayTime.minute}:00");
      }
    }
  }

  _selectsaturdayStartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedsaturdayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedsaturdayTendime) {
      setState(() {
        selectedsaturdayTendime = timeOfDay;
      });

      var selectdate = selectedsaturdayTendime.hour;
      var selectminitue = selectedsaturdayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _saturdayStarTime(0,
            "0000-00-00 0${selectedsaturdayTendime.hour}:0${selectedsaturdayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _saturdayStarTime(0,
            "0000-00-00 ${selectedsaturdayTendime.hour}:0${selectedfridayTime.minute}:00");
      } else if (selectdate < 9) {
        _saturdayStarTime(0,
            "0000-00-00 0${selectedsaturdayTendime.hour}:${selectedsaturdayTendime.minute}:00");
      } else if (selectdate > 9) {
        _saturdayStarTime(0,
            "0000-00-00 ${selectedsaturdayTendime.hour}:${selectedsaturdayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedsaturdayTendime = selectedsaturdayTendime;
      });
    }
  }

// ========================================saterday end=============================================

// ============================= friday==================================
  TimeOfDay selectedfridayTime = TimeOfDay.now();
  TimeOfDay selectedfridayTendime = TimeOfDay.now();
  selectfridaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedfridayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedfridayTime) {
      setState(() {
        selectedfridayTime = timeOfDay;
      });

      var selectdate = selectedfridayTime.hour;
      var selectminitue = selectedfridayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _fridayStarTime(0,
            "0000-00-00 0${selectedfridayTime.hour}:0${selectedfridayTime.minute}:00");
      } else if (selectminitue < 9) {
        _fridayStarTime(0,
            "0000-00-00 ${selectedfridayTime.hour}:0${selectedfridayTime.minute}:00");
      } else if (selectdate < 9) {
        _fridayStarTime(0,
            "0000-00-00 0${selectedfridayTime.hour}:${selectedfridayTime.minute}:00");
      } else if (selectdate > 9) {
        _fridayStarTime(0,
            "0000-00-00 ${selectedfridayTime.hour}:${selectedfridayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedfridayTime = selectedfridayTime;
      });
    }
  }

  selectfridayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedfridayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedfridayTendime) {
      setState(() {
        selectedfridayTendime = timeOfDay;
      });

      var selectdate = selectedfridayTendime.hour;
      var selectminitue = selectedfridayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        fridayEnTime(0,
            "0000-00-00 0${selectedfridayTendime.hour}:0${selectedfridayTendime.minute}:00");
      } else if (selectminitue < 9) {
        fridayEnTime(0,
            "0000-00-00 ${selectedfridayTendime.hour}:0${selectedfridayTendime.minute}:00");
      } else if (selectdate < 9) {
        fridayEnTime(0,
            "0000-00-00 0${selectedfridayTendime.hour}:${selectedfridayTendime.minute}:00");
      } else if (selectdate > 9) {
        fridayEnTime(0,
            "0000-00-00 ${selectedfridayTendime.hour}:${selectedfridayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedfridayTendime = selectedfridayTendime;
      });
    }
  }

// ========================================fri end=============================================

// =============================thursday ==================================
  TimeOfDay selectedthurdayTime = TimeOfDay.now();
  TimeOfDay selectedthurdayTendime = TimeOfDay.now();
  selectthurdaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedthurdayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedthurdayTime) {
      setState(() {
        selectedthurdayTime = timeOfDay;
      });

      var selectdate = selectedthurdayTime.hour;
      var selectminitue = selectedthurdayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _thursdayStarTime(0,
            "0000-00-00 0${selectedthurdayTime.hour}:0${selectedthurdayTime.minute}:00");
      } else if (selectminitue < 9) {
        _thursdayStarTime(0,
            "0000-00-00 ${selectedthurdayTime.hour}:0${selectedthurdayTime.minute}:00");
      } else if (selectdate < 9) {
        _thursdayStarTime(0,
            "0000-00-00 0${selectedthurdayTime.hour}:${selectedthurdayTime.minute}:00");
      } else if (selectdate > 9) {
        _thursdayStarTime(0,
            "0000-00-00 ${selectedthurdayTime.hour}:${selectedthurdayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedthurdayTime = selectedthurdayTime;
      });
    }
  }

  selectthurdayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedthurdayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedthurdayTendime) {
      setState(() {
        selectedthurdayTendime = timeOfDay;
      });

      var selectdate = selectedthurdayTendime.hour;
      var selectminitue = selectedthurdayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _thursdayEnTime(0,
            "0000-00-00 0${selectedthurdayTendime.hour}:0${selectedthurdayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _thursdayEnTime(0,
            "0000-00-00 ${selectedthurdayTendime.hour}:0${selectedthurdayTendime.minute}:00");
      } else if (selectdate < 9) {
        _thursdayEnTime(0,
            "0000-00-00 0${selectedthurdayTendime.hour}:${selectedthurdayTendime.minute}:00");
      } else if (selectdate > 9) {
        _thursdayEnTime(0,
            "0000-00-00 ${selectedthurdayTendime.hour}:${selectedthurdayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedthurdayTendime = selectedthurdayTendime;
      });
    }
  }

// ========================================thurday end=============================================

// =============================widnessday ==================================
  TimeOfDay selectedwidnesdayTime = TimeOfDay.now();
  TimeOfDay selectedwidnesdayTendime = TimeOfDay.now();
  selectwidnesdaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedwidnesdayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedwidnesdayTime) {
      setState(() {
        selectedwidnesdayTime = timeOfDay;
      });

      var selectdate = selectedwidnesdayTime.hour;
      var selectminitue = selectedwidnesdayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _wednesdayStarTime(0,
            "0000-00-00 0${selectedwidnesdayTime.hour}:0${selectedwidnesdayTime.minute}:00");
      } else if (selectminitue < 9) {
        _wednesdayStarTime(0,
            "0000-00-00 ${selectedwidnesdayTime.hour}:0${selectedwidnesdayTime.minute}:00");
      } else if (selectdate < 9) {
        _wednesdayStarTime(0,
            "0000-00-00 0${selectedwidnesdayTime.hour}:${selectedwidnesdayTime.minute}:00");
      } else if (selectdate > 9) {
        _wednesdayStarTime(0,
            "0000-00-00 ${selectedwidnesdayTime.hour}:${selectedwidnesdayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedwidnesdayTime = selectedwidnesdayTime;
      });
    }
  }

  selectwidnesdayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedwidnesdayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedwidnesdayTendime) {
      setState(() {
        selectedwidnesdayTendime = timeOfDay;
      });

      var selectdate = selectedwidnesdayTendime.hour;
      var selectminitue = selectedwidnesdayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _wednesdayEnTime(0,
            "0000-00-00 0${selectedwidnesdayTendime.hour}:0${selectedwidnesdayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _wednesdayEnTime(0,
            "0000-00-00 ${selectedwidnesdayTendime.hour}:0${selectedwidnesdayTendime.minute}:00");
      } else if (selectdate < 9) {
        _wednesdayEnTime(0,
            "0000-00-00 0${selectedwidnesdayTendime.hour}:${selectedwidnesdayTendime.minute}:00");
      } else if (selectdate > 9) {
        _wednesdayEnTime(0,
            "0000-00-00 ${selectedwidnesdayTendime.hour}:${selectedwidnesdayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedwidnesdayTendime = selectedwidnesdayTendime;
      });
    }
  }

// ========================================widnesday end=============================================
// =============================sunsday ==================================
  TimeOfDay selectedsundayTime = TimeOfDay.now();
  TimeOfDay selectedsundayTendime = TimeOfDay.now();
  selectsundaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedsundayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedsundayTime) {
      setState(() {
        selectedsundayTime = timeOfDay;
      });

      var selectdate = selectedsundayTime.hour;
      var selectminitue = selectedsundayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _sundayStarTime(0,
            "0000-00-00 0${selectedsundayTime.hour}:0${selectedsundayTime.minute}:00");
      } else if (selectminitue < 9) {
        _sundayStarTime(0,
            "0000-00-00 ${selectedsundayTime.hour}:0${selectedsundayTime.minute}:00");
      } else if (selectdate < 9) {
        _sundayStarTime(0,
            "0000-00-00 0${selectedsundayTime.hour}:${selectedsundayTime.minute}:00");
      } else if (selectdate > 9) {
        _sundayStarTime(0,
            "0000-00-00 ${selectedsundayTime.hour}:${selectedsundayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedsundayTime = selectedsundayTime;
      });
    }
  }

  selectsundayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedsundayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedsundayTendime) {
      setState(() {
        selectedsundayTendime = timeOfDay;
      });

      var selectdate = selectedsundayTendime.hour;
      var selectminitue = selectedsundayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _sundayEnTime(0,
            "0000-00-00 0${selectedsundayTendime.hour}:0${selectedsundayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _sundayEnTime(0,
            "0000-00-00 ${selectedsundayTendime.hour}:0${selectedsundayTendime.minute}:00");
      } else if (selectdate < 9) {
        _sundayEnTime(0,
            "0000-00-00 0${selectedsundayTendime.hour}:${selectedsundayTendime.minute}:00");
      } else if (selectdate > 9) {
        _sundayEnTime(0,
            "0000-00-00 ${selectedsundayTendime.hour}:${selectedsundayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedsundayTendime = selectedsundayTendime;
      });
    }

    print(selectedsundayTendime);
  }

// ========================================widnesday end=============================================
// =============================monday ==================================
  TimeOfDay selectedmondayTime = TimeOfDay.now();
  TimeOfDay selectedmondayTendime = TimeOfDay.now();
  selectmondaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedmondayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedmondayTime) {
      setState(() {
        selectedmondayTime = timeOfDay;
      });

      var selectdate = selectedmondayTime.hour;
      var selectminitue = selectedmondayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _mondayStarTime(0,
            "0000-00-00 0${selectedmondayTime.hour}:0${selectedmondayTime.minute}:00");
      } else if (selectminitue < 9) {
        _mondayStarTime(0,
            "0000-00-00 ${selectedmondayTime.hour}:0${selectedtuesdayTime.minute}:00");
      } else if (selectdate < 9) {
        _mondayStarTime(0,
            "0000-00-00 0${selectedmondayTime.hour}:${selectedmondayTime.minute}:00");
      } else if (selectdate > 9) {
        _mondayStarTime(0,
            "0000-00-00 ${selectedmondayTime.hour}:${selectedmondayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedmondayTime = selectedmondayTime;
      });
    }
  }

  selectmondayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedmondayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedmondayTendime) {
      setState(() {
        selectedmondayTendime = timeOfDay;
      });

      var selectdate = selectedmondayTendime.hour;
      var selectminitue = selectedmondayTendime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _mondayEnTime(0,
            "0000-00-00 0${selectedmondayTendime.hour}:0${selectedmondayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _mondayEnTime(0,
            "0000-00-00 ${selectedmondayTendime.hour}:0${selectedmondayTendime.minute}:00");
      } else if (selectdate < 9) {
        _mondayEnTime(0,
            "0000-00-00 0${selectedmondayTendime.hour}:${selectedmondayTendime.minute}:00");
      } else if (selectdate > 9) {
        _mondayEnTime(0,
            "0000-00-00 ${selectedmondayTendime.hour}:${selectedmondayTendime.minute}:00");
      }
    } else {
      setState(() {
        selectedmondayTendime = selectedmondayTendime;
      });
    }
  }

// ========================================monday end=============================================

// =============================monday ==================================
  TimeOfDay selectedtuesdayTime = TimeOfDay.now();
  TimeOfDay selectedtuesdayTendime = TimeOfDay.now();
  selecttuesdaystartTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedtuesdayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedtuesdayTime) {
      setState(() {
        selectedtuesdayTime = timeOfDay;
      });

      var selectdate = selectedtuesdayTime.hour;
      var selectminitue = selectedtuesdayTime.minute;
      if (selectdate < 9 && selectminitue < 9) {
        _tuesdayStarTime(0,
            "0000-00-00 0${selectedtuesdayTime.hour}:0${selectedtuesdayTime.minute}:00");
      } else if (selectminitue < 9) {
        _tuesdayStarTime(0,
            "0000-00-00 ${selectedtuesdayTime.hour}:0${selectedtuesdayTime.minute}:00");
      } else if (selectdate < 9) {
        _tuesdayStarTime(0,
            "0000-00-00 0${selectedtuesdayTime.hour}:${selectedtuesdayTime.minute}:00");
      } else if (selectdate > 9) {
        _tuesdayStarTime(0,
            "0000-00-00 ${selectedtuesdayTime.hour}:${selectedtuesdayTime.minute}:00");
      }
    } else {
      setState(() {
        selectedtuesdayTime = selectedtuesdayTime;
      });
    }
  }

  selecttuesdayendTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff128041),
            accentColor: Color(0xff128041),
            colorScheme: ColorScheme.light(primary: const Color(0xff128041)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      context: context,
      initialTime: selectedtuesdayTendime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedtuesdayTendime) {
      setState(() {
        selectedtuesdayTendime = timeOfDay;
      });

      var selectdate = selectedtuesdayTendime.hour;
      var selectminitue = selectedtuesdayTendime.minute;

      if (selectdate < 9 && selectminitue < 9) {
        _tuesdayEnTime(0,
            "0000-00-00 0${selectedtuesdayTendime.hour}:0${selectedtuesdayTendime.minute}:00");
      } else if (selectdate < 9) {
        _tuesdayEnTime(0,
            "0000-00-00 0${selectedtuesdayTendime.hour}:${selectedtuesdayTendime.minute}:00");
      } else if (selectminitue < 9) {
        _tuesdayEnTime(0,
            "0000-00-00 ${selectedtuesdayTendime.hour}:0${selectedtuesdayTendime.minute}:00");
      } else if (selectdate > 9) {
        _tuesdayEnTime(0,
            "0000-00-00 ${selectedtuesdayTendime.hour}:${selectedtuesdayTendime.minute}:00");
      }
    }
  }

// ========================================monday end=============================================
  var photo;
  userdatagetphoto() async {
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
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed(RouteManeger.dashboad_page);
      },
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
        body: WillPopScope(
          onWillPop: () => Navigator.of(context)
              .popAndPushNamed(RouteManeger.shecduleshow_page),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Create Schedule",
                            style: GoogleFonts.roboto(
                              fontSize: 20.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ), //596970
                          ),
                          Divider(
                            color: Color(0xff000000),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 52.h,
                            // height: MediaQuery.of(context).size.height * 0.068,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.black54,
                                // ),
                                color: Color(0xffffffff), //E9F2F2
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  )
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: _onlinestatus == null
                                      ? Text(
                                          'Select online status',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          _onlinestatus,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.h,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color(0xFF323232),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  items: onlinestatus.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                          child: Text(val), value: val);
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    if (val == "Online") {
                                      setState(
                                        () {
                                          isvisible20 = false;
                                          _onlinestatus = val;
                                          print(_onlinestatus);
                                        },
                                      );
                                      chamberlistfunction();
                                    } else {
                                      setState(
                                        () {
                                          _onlinestatus = val;
                                          isvisible20 = true;
                                          print(_onlinestatus);
                                        },
                                      );
                                      chamberlistfunction();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Visibility(
                            visible: isvisible20,
                            child: Container(
                              height: 52.h,
                              // height:
                              //     MediaQuery.of(context).size.height * 0.068,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.black54,
                                  // ),
                                  color: Color(0xffffffff), //E9F2F2
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: _chamber == null
                                        ? Text(
                                            'Select your chamber',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: Color(0xFF323232),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : Text(
                                            _chamber,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: Color(0xFF323232),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                    isExpanded: true,
                                    iconSize: 30.h,
                                    style: TextStyle(color: Colors.black),
                                    items: chamberlist.map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                            child: Text(val['chamber_name']),
                                            value: val['chamber_name']);
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(
                                        () {
                                          _chamber = val;
                                          print(_chamber);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    buildpatientlimit(patientlimitcontroller),
                    SizedBox(
                      height: 5.h,
                    ),
                    buildintervaltime(intervalTimecontroller),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: su,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value1) {
                              setState(() {
                                su = value1;
                                print(su);
                                isChecked1 = !isChecked1;
                              });
                            }),
                        Text(
                          'Sunday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // var chamber = sundayone[index];
                            Visibility(
                              visible: isVisible,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, top: 5.h, bottom: 5.h),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _count,
                                  itemBuilder: (context, index) {
                                    return sunsheduleformwidget(index);
                                  },
                                ),
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: mo,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value2) {
                              setState(() {
                                mo = value2;
                                isChecked2 = !isChecked2;
                              });
                            }),
                        Text(
                          'Monday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // var chamber = sundayone[index];
                            Visibility(
                              visible: isVisible,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, top: 5.h, bottom: 5.h),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _moncount,
                                  itemBuilder: (context, index) {
                                    return monsheduleformwidget(index);
                                  },
                                ),
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: tu,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value3) {
                              setState(() {
                                tu = value3;
                                isChecked3 = !isChecked3;
                              });
                            }),
                        Text(
                          ' Tuesday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // var chamber = sundayone[index];
                            Visibility(
                              visible: isVisible,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, top: 5.h, bottom: 5.h),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _tuecount,
                                  itemBuilder: (context, index) {
                                    return tuessheduleformwidget(index);
                                  },
                                ),
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: wed,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value4) {
                              setState(() {
                                wed = value4;
                                isChecked4 = !isChecked4;
                              });
                            }),
                        Text(
                          'Wednesday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked4,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // var chamber = sundayone[index];
                            Visibility(
                              visible: isVisible,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, top: 5.h, bottom: 5.h),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _wedcount,
                                  itemBuilder: (context, index) {
                                    return wednessheduleformwidget(index);
                                  },
                                ),
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: th,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value5) {
                              setState(() {
                                th = value5;
                                isChecked5 = !isChecked5;
                              });
                            }),
                        Text(
                          'Thursday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // var chamber = sundayone[index];
                          Visibility(
                            visible: isVisible,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 5.h, bottom: 5.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _thurscount,
                                itemBuilder: (context, index) {
                                  return thurssheduleformwidget(index);
                                },
                              ),
                              // ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: fr,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value6) {
                              setState(() {
                                fr = value6;
                                isChecked6 = !isChecked6;
                              });
                            }),
                        Text(
                          'Friday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // var chamber = sundayone[index];
                          Visibility(
                            visible: isVisible,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 5.h, bottom: 5.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _fricount,
                                itemBuilder: (context, index) {
                                  return frisheduleformwidget(index);
                                },
                              ),
                              // ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: sa,
                            checkColor: Colors.white,
                            activeColor: Color(0xff128041),
                            onChanged: (bool value7) {
                              setState(() {
                                sa = value7;
                                isChecked7 = !isChecked7;
                              });
                            }),
                        Text(
                          'Saturday',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isChecked7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // var chamber = sundayone[index];
                          Visibility(
                            visible: isVisible,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 5.h, bottom: 5.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _saturcount,
                                itemBuilder: (context, index) {
                                  return satursheduleformwidget(index);
                                },
                              ),
                              // ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffFF0D0D),
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Color(0xFFfffffff),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed(
                                  RouteManeger.shecduleshow_page);
                            },
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              child: Text(
                                "Save",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Color(0xFFffffff),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff128041),
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (intervalTimecontroller.text == "") {
                                  internaterror(
                                      "Filled can't be blank ", context);
                                } else if (patientlimitcontroller.text == "") {
                                  internaterror(
                                      "Filled can't be blank", context);
                                } else {
                                  sheduleController.shedulesetup(
                                      _chamber,
                                      intervalTimecontroller.text,
                                      patientlimitcontroller.text,
                                      su,
                                      _sundaystartjsonvalu,
                                      _sundayendjsonvalu,
                                      mo,
                                      _mondaystartjsonvalu,
                                      _mondayendjsonvalu,
                                      tu,
                                      _tuesdaystartjsonvalu,
                                      _tuesdayendjsonvalu,
                                      wed,
                                      _wednesdaystartjsonvalu,
                                      _wednesdayendjsonvalu,
                                      th,
                                      _thursdaystartjsonvalu,
                                      _thursdayendjsonvalu,
                                      fr,
                                      _fridaystartjsonvalu,
                                      _fridayendjsonvalu,
                                      sa,
                                      _saturdaystartjsonvalu,
                                      _saturdayendjsonvalu,
                                      _onlinestatus,
                                      context);
                                }
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget satursheduleformwidget(int key) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.black),
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  'Start time  ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 50.h,
                width: 80.w,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Color(0xffFFFFFF), //E9F2F2
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child:

                    // ignore: deprecated_member_use
                    RaisedButton(
                  onPressed: () {
                    _selectsaturdayStartTime(context);
                  },
                  // child: Text(DateFormat("h:mma").format(DateTime.parse(
                  //     "0000-00-00 ${selectedsaturdayTendime.hour}:${selectedsaturdayTendime.minute}:00"))),
                  child: Text(
                      "${selectedsaturdayTendime.hour}:${selectedsaturdayTendime.minute}"),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'End time',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                  height: 50.h,
                  width: 80.w,
                  // height: MediaQuery.of(context).size.height * 0.05,
                  // width: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF), //E9F2F2
                      borderRadius: BorderRadius.circular(2.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: RaisedButton(
                    onPressed: () {
                      _selectsaturdayEnTime(context);
                    },
                    // child: Text(DateFormat("h:mma").format(DateTime.parse(
                    //     "0000-00-00 ${selectedsaturdayTime.hour}:${selectedsaturdayTime.minute}:00"))),
                    child: Text(
                        "${selectedsaturdayTime.hour}:${selectedsaturdayTime.minute}"),
                  )),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.05,
              //   width: MediaQuery.of(context).size.height * 0.05,
              //   decoration: BoxDecoration(
              //       color: Color(0xffFFFFFF), //E9F2F2
              //       borderRadius: BorderRadius.circular(2),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black12,
              //           blurRadius: 6,
              //           offset: Offset(0, 2),
              //         )
              //       ]),
              // ),
            ],
          )),
    );
  }

  Widget frisheduleformwidget(int key) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  'Start time',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 50.h,
                width: 80.w,
                // height: MediaQuery.of(context).size.height * 0.05,
                // width: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Color(0xffFFFFFF), //E9F2F2
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: RaisedButton(
                  onPressed: () {
                    selectfridaystartTime(context);
                  },
                  child: Text(
                    "${selectedfridayTime.hour}:${selectedfridayTime.minute}"
                        .toString(),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'End time',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 50.h,
                width: 80.w,
                // height: MediaQuery.of(context).size.height * 0.05,
                // width: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), //E9F2F2
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: RaisedButton(
                  onPressed: () {
                    selectfridayendTime(context);
                  },
                  child: Text(
                    " ${selectedfridayTendime.hour}:${selectedfridayTendime.minute}"
                        .toString(),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget thurssheduleformwidget(int key) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Container(
          height: 52.h,
          // height: MediaQuery.of(context).size.height * 0.068,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //E9F2F2
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  'Start time ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 50.h,
                width: 80.w,
                // height: MediaQuery.of(context).size.height * 0.05,
                // width: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Color(0xffFFFFFF), //E9F2F2
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: RaisedButton(
                  onPressed: () {
                    selectthurdaystartTime(context);
                  },
                  child: Text(
                    " ${selectedthurdayTime.hour}:${selectedthurdayTime.minute}"
                        .toString(),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'End time',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 50.h,
                width: 80.w,
                // height: MediaQuery.of(context).size.height * 0.05,
                // width: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Color(0xffFFFFFF), //E9F2F2
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: RaisedButton(
                  onPressed: () {
                    selectthurdayendTime(context);
                  },
                  child: Text(
                    "${selectedthurdayTendime.hour}:${selectedthurdayTendime.minute}"
                        .toString(),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget wednessheduleformwidget(int key) {
    return Container(
        height: 52.h,
        // height: MediaQuery.of(context).size.height * 0.068,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //E9F2F2
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                'Start time  ',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectwidnesdaystartTime(context);
                },
                child: Text(
                  " ${selectedwidnesdayTime.hour}:${selectedwidnesdayTime.minute}"
                      .toString(),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'End Time',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectwidnesdayendTime(context);
                },
                child: Text(
                  " ${selectedwidnesdayTendime.hour}:${selectedwidnesdayTendime.minute}"
                      .toString(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget sunsheduleformwidget(int key) {
    return Container(
        height: 52.h,
        // height: MediaQuery.of(context).size.height * 0.068,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //E9F2F2
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                'Start time ',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectsundaystartTime(context);
                },
                child: Text(
                  " ${selectedsundayTime.hour}:${selectedsundayTime.minute}"
                      .toString(),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'End time',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectsundayendTime(context);
                },
                child: Text(
                  "${selectedsundayTendime.hour}:${selectedsundayTendime.minute}"
                      .toString(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget monsheduleformwidget(int key) {
    return Container(
        height: 52.h,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //E9F2F2
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                'Start time',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectmondaystartTime(context);
                },
                child: Text(
                  " ${selectedmondayTime.hour}:${selectedmondayTime.minute}"
                      .toString(),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'End time',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selectmondayendTime(context);
                },
                child: Text(
                  " ${selectedmondayTendime.hour}:${selectedmondayTendime.minute}"
                      .toString(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget tuessheduleformwidget(int key) {
    return Container(
        height: 52.h,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //E9F2F2
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                'Start time',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selecttuesdaystartTime(context);
                },
                child: Text(
                  " ${selectedtuesdayTime.hour}:${selectedtuesdayTime.minute}"
                      .toString(),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'End time',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Color(0xFF323232),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 50.h,
              width: 80.w,
              // height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Color(0xffFFFFFF), //E9F2F2
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: RaisedButton(
                onPressed: () {
                  selecttuesdayendTime(context);
                },
                child: Text(
                  "${selectedtuesdayTendime.hour}:${selectedtuesdayTendime.minute}"
                      .toString(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildpatientlimit(patientlimitcontroller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Patient Limit",
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Color(0xFF323232),
              fontWeight: FontWeight.w600,
            ), //596970
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 52.h,
            // height: MediaQuery.of(context).size.height * 0.068,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.black54,
                // ),
                color: Color(0xffffffff), //E9F2F2
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: TextFormField(
                controller: patientlimitcontroller,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    // prefixIcon: Icon(
                    //   Icons.person,
                    //   color: Color(0xffA7ADBC),
                    // ),
                    hintText: '15 member',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Color(0xFF323232),
                      fontWeight: FontWeight.w600,
                    )), //A7ADBC
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildintervaltime(intervalTimecontroller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Interval Time",
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Color(0xFF323232),
              fontWeight: FontWeight.w600,
            ), //596970
            //596970
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 52.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.black54,
                // ),
                color: Color(0xffffffff), //E9F2F2
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: TextFormField(
                controller: intervalTimecontroller,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    // prefixIcon: Icon(
                    //   Icons.schedule,
                    //   color: Color(0xffA7ADBC),
                    // ),
                    hintText: '15 mintune',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Color(0xFF323232),
                      fontWeight: FontWeight.w600,
                    )), //A7ADBC
              ),
            ),
          )
        ],
      ),
    );
  }
}

void internaterror(String massge, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(massge),
      action: SnackBarAction(
          label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
