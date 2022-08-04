import 'package:doctot_sasthoo/Screen_page/ChamberPage/ChamberSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/ChamberPage/chambercreate_page.dart';
import 'package:doctot_sasthoo/Screen_page/Dashboad_page.dart';
import 'package:doctot_sasthoo/Screen_page/FamillyPage/famillysearch.dart';
import 'package:doctot_sasthoo/Screen_page/FamillyPage/famillysetup.dart';
import 'package:doctot_sasthoo/Screen_page/FamillyPage/familylist.dart';
import 'package:doctot_sasthoo/Screen_page/Feedback_page.dart';
import 'package:doctot_sasthoo/Screen_page/FeesPage/FeeSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/FeesPage/feesedit_page.dart';
import 'package:doctot_sasthoo/Screen_page/AppoinmentPage/Patientdetails_page.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/workingexperience.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/genarelinformation.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/profile.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/uploadimage.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/education.dart';
import 'package:doctot_sasthoo/Screen_page/ProfilePage/workingexperienceedit.dart';
import 'package:doctot_sasthoo/Screen_page/Shedule/newschedulepage.dart';
import 'package:doctot_sasthoo/Screen_page/SpecialistPage/addspeciallistpage.dart';
import 'package:doctot_sasthoo/Screen_page/SpecialistPage/specialistviewpage.dart';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/StaffSetup_page.dart';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/Stafflist_page.dart';
import 'package:doctot_sasthoo/Screen_page/Stafflist.dart/stafflistedit_page.dart';
import 'package:doctot_sasthoo/Screen_page/TransectionPage/cancelpatientpage.dart';
import 'package:doctot_sasthoo/Screen_page/TransectionPage/transectionpage.dart';
import 'package:doctot_sasthoo/Screen_page/TransectionPage/withdrawpage.dart';
import 'package:doctot_sasthoo/Screen_page/WalletPage/Wallet_page.dart';
import 'package:doctot_sasthoo/Screen_page/WalletPage/walletedit.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Login_page.dart';
import 'package:doctot_sasthoo/Screen_page/Shedule/Schedule_page.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Registration_page.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Splash_page.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Verification_otp.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/Verification_phone.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/forgetotppage.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/forgetpasswordpage.dart';
import 'package:doctot_sasthoo/Screen_page/logRigPage/updatepassword.dart';
import 'package:doctot_sasthoo/main.dart';
import 'package:flutter/material.dart';

import '../Screen_page/Prescription_page/Prescription_page.dart';

class RouteManeger {
  static const String loginmainpage = "/";
  static const String splashs_page = "/splashs_page";
  static const String home_page = "/home_page";
  static const String loginin_page = "/loginin_page";
  static const String regin_page = "/regin_page";
  static const String otp_page = "/otp_page";
  static const String phnver_page = "/phnver_page";
  static const String uploadimage_page = "/uploadimage_page";
  static const String dashboad_page = "/dashboad_page";
  static const String shecduleshow_page = "/shecduleshow_page";
  static const String profile_page = "/profile_page";
  static const String profileoption_page = "/profileoption_page";
  static const String education_page = "/education_page";
  static const String working_page = "/working_page";
  static const String genarel_page = "/genarel_page ";
  static const String staff_page = "/staff_page ";
  static const String patientdetils_page = "/patientdetils_page";
  static const String feback_page = "/feedback_page";
  static const String familysetup_page = "/familysetup_page";
  static const String familylist_page = "/familylist_page";
  static const String chamberedit_page = "/chamberedit_page";
  static const String chambersetup_page = "/chambersetup_page";
  static const String wallet_page = "/wallet_page";
  static const String walletedit_page = "/walletedit_page";
  static const String stafflistedit_page = "/stafflistedit_page";
  static const String staffsetup_page = "/staffsetup_page";
  static const String feesedit_page = "/feesedit_page";
  static const String feeslist_page = "/feeslist_page";
  static const String familysearch_page = "/familysearch_page";
  static const String familylistadd_page = "/familylistadd_page";
  static const String shecdulecreate_page = "/shecdulecreate_page";
  static const String trangeciton_page = "/trangeciton_page";
  static const String withdraw_page = "/withdraw_page";
  static const String cancelpatient_page = "/cancelpatient_page";
  static const String workingedit_page = "/ workingedit_page";
  static const String forgetpasswordpage_page = "/ forgetpasswordpage_page";
  static const String forgetotp_page = "/ forgetotp_page ";
  static const String updatepassword_page = "/updatepassword_page ";
  static const String specialist_page = "/specialist_page";
  static const String addspecialist_page = "/addspecialist_page";
  static const String prescription = "/prescription";

  static Route<dynamic> generateroute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginmainpage:
        return MaterialPageRoute(
          builder: (context) => LoginFunction(),
        );
      case splashs_page:
        return MaterialPageRoute(
          builder: (context) => splash_page(),
        );
      case loginin_page:
        return MaterialPageRoute(
          builder: (context) => Login_Page(),
        );
      case home_page:
        return MaterialPageRoute(
          builder: (context) => Dashboad_page(),
        );
      case regin_page:
        return MaterialPageRoute(
          builder: (context) => Registration_page(),
        );

      case otp_page:
        return MaterialPageRoute(
          builder: (context) => Verification_otp(),
        );
      case phnver_page:
        return MaterialPageRoute(
          builder: (context) => Verification_phone(),
        );
      case uploadimage_page:
        return MaterialPageRoute(
          builder: (context) => Uploadimage(),
        );
      case dashboad_page:
        return MaterialPageRoute(
          builder: (context) => Dashboad_page(),
        );
      case shecduleshow_page:
        return MaterialPageRoute(
          builder: (context) => Schedule_page(),
        );
      case shecdulecreate_page:
        return MaterialPageRoute(
          builder: (context) => NewSchedulePage(),
        );
      case profile_page:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );

      case education_page:
        return MaterialPageRoute(
          builder: (context) => EducationExperience(),
        );
      case working_page:
        return MaterialPageRoute(
          builder: (context) => WorkingExperience(),
        );
      case genarel_page:
        return MaterialPageRoute(
          builder: (context) => GenarelInformation(''),
        );
      case staff_page:
        return MaterialPageRoute(
          builder: (context) => Stafflist_page(),
        );
      case staffsetup_page:
        return MaterialPageRoute(
          builder: (context) => StaffSetup_page(),
        );
      case stafflistedit_page:
        return MaterialPageRoute(
          builder: (context) => Stafflisteditpage(''),
        );
      case patientdetils_page:
        return MaterialPageRoute(
          builder: (context) => Patientdetails_page(args),
        );
      case feback_page:
        return MaterialPageRoute(
          builder: (context) => feedback_page(),
        );
      case familysetup_page:
        return MaterialPageRoute(
          builder: (context) => FamillyListPage(),
        );
      case familysearch_page:
        return MaterialPageRoute(
          builder: (context) => Familysearch(args),
        );
      case chambersetup_page:
        return MaterialPageRoute(
          builder: (context) => ChamberSetup_page(),
        );
      case chamberedit_page:
        return MaterialPageRoute(
          builder: (context) => ChamberEditPage(''),
        );
      case wallet_page:
        return MaterialPageRoute(
          builder: (context) => Wallet_page(),
        );
      case walletedit_page:
        return MaterialPageRoute(
          builder: (context) => WalletEditPage(''),
        );
      case stafflistedit_page:
        return MaterialPageRoute(
          builder: (context) => Stafflisteditpage(''),
        );
      case feesedit_page:
        return MaterialPageRoute(
          builder: (context) => FeesEdit_page(args),
        );
      case feeslist_page:
        return MaterialPageRoute(
          builder: (context) => FeeSetup_page(),
        );
      case familylistadd_page:
        return MaterialPageRoute(
          builder: (context) => Familylist(''),
        );
      case trangeciton_page:
        return MaterialPageRoute(
          builder: (context) => TransectionPage(),
        );
      case withdraw_page:
        return MaterialPageRoute(
          builder: (context) => WithdrwaList(),
        );
      case cancelpatient_page:
        return MaterialPageRoute(
          builder: (context) => CancelpatientPage(),
        );
      case workingedit_page:
        return MaterialPageRoute(
          builder: (context) => WorkingexperinseEdit(''),
        );
      case forgetpasswordpage_page:
        return MaterialPageRoute(
          builder: (context) => ForgetVerficationPhone_page(),
        );
      case forgetotp_page:
        return MaterialPageRoute(
          builder: (context) => VerficationOtpforget(''),
        );
      case updatepassword_page:
        return MaterialPageRoute(
          builder: (context) => UpdatePasswordPage(''),
        );
      case specialist_page:
        return MaterialPageRoute(
          builder: (context) => SpecialistViewpage(),
        );
      case addspecialist_page:
        return MaterialPageRoute(
          builder: (context) => AddSpecilestPage(),
        );
      case prescription:
        return MaterialPageRoute(
          builder: (context) => Prescription_page(args),
        );

      default:
        throw FormatException('Route not found check route again');
    }
  }
}
