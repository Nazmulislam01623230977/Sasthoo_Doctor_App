class Baseurl {
  static var mainurl = "https://digitalshasthoo.reflexit.com.bd";
}

class ApiRepo {
  static var phoneurl = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user/mobile-apps-user-otp-send");
  static var otpverify = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user/mobile-apps-user-otp-verify");
  static var regverify = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user/mobile-apps-user-registration");
  static var loginurl =
      Uri.parse("${Baseurl.mainurl}" + "/api/mobile_apps_user/userlogin");
  static var recievedPhoto = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/userregphotupdate");
  static var userdata = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/getuserdata");
  static var profileeditdata = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/profile-edit");
  static var workingexperence = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/working-experiences-save");
  static var workingexpurl = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/workingexperiences/";
  static var educationexpurl = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/educationexperiences/";
  static var chamberlist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/chamberlist/";
  static var chmbersetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/chambersetup");
  static var chamberdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/chamberdelete/";
  static var chmberedit = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/chamberedit");
  static var educationsave = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/education_experiences-save");
  static var educationupdate = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/education_experiences-update");
  static var educationdelete = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/education_experiences-delete");
  static var workingsave = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/working-experiences-save");
  static var workingupdate = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/working-experiences-update");
  static var workingdelete = Uri.parse("${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/working-experiences-delete");
  static var uphotoupload = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/userphotoupdate");
  static var walletsetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/waletessetup");
  static var walletlist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/waleteslist/";
  static var walletedit = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/waleteedit");
  static var walletdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/waletesdelete/";
  static var staffsetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/stafsave");
  static var stafflist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/staflist/";
  static var stafedit = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/stafedit");

  static var doctorfreeeidt = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/doctorfreesupdate");
  static var staffdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/stafdelet/";
  static var doctorfeesetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/doctorfreesetup");
  static var schedulesetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/schedulesetup");
  static var schedulist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/schedulelist/";
  static var schedulistforfree = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/schedulelistforfee/";
  static var schedulistforfreechamber = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/shedilueforchamber/";
  static var alltest =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/alltest";
  static var schedulistdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/scheduledelete/";
  static var prescriptionsend =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/givenprescription";
  static var doctorfree =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/doctorfreeslist/";

  static var doctorofflinefree = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/offlinedoctorfreeslist/";
  static var feesdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/doctorfreesdelete/";
  static var familylist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/famillylist/";
  static var familysetup = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/famillysetup");
  static var familylistadd = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/famillylistafteradd/";
  static var familydelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/famillylistdelete/";
  static var shedulelist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/schedulelist/";
  static var profileshedulelist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/profileshedule/";
  static var onlineprofileshedulelist = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/profileonlineshedule/";

  static var shedulestatuschange = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/sedulestatuschange/";
  static var transactionlist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/accountshistory/";
  static var totalamount =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/totalblance/";
  static var appoinmentlist = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/doctorappoinmentlist/";
  static var todayappoinment = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/todaydoctorappoinmentlist/";
  static var emergencyappoinmentlist = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/emergencydoctorappoinmentlist/";

  static var offlineappoinmentlist = "${Baseurl.mainurl}" +
      "/api/mobile_apps_user_profile/oflinedoctorappoinmentlist/";

  static var appoinmentDetails =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/appoinmentdetails/";
  static var forgetphonenum = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user/forgetpasswordphone");
  static var forgetotpnum =
      Uri.parse("${Baseurl.mainurl}" + "/api/mobile_apps_user/forgetotpverify");
  static var changepassword =
      Uri.parse("${Baseurl.mainurl}" + "/api/mobile_apps_user/newpassword");
  static var spceil =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user/specialitys";
  static var subspceil =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user/subspecialitys/";
  static var specialtsave = Uri.parse(
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/specialitysave");
  static var speciallist =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/specialitylist/";
  static var specialistdelete =
      "${Baseurl.mainurl}" + "/api/mobile_apps_user_profile/specialitydelete/";
}
