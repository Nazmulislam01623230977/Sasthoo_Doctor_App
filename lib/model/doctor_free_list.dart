import 'dart:convert';

List<DoctorFree> doctorFreeFromJson(String str) =>
    List<DoctorFree>.from(json.decode(str).map((x) => DoctorFree.fromJson(x)));

String doctorFreeToJson(List<DoctorFree> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorFree {
  DoctorFree({
    this.day,
    this.onlineStatus,
    this.oldPatientFree,
    this.newPatientFree,
    this.reportPatientFree,
    this.id,
  });

  String day;
  String onlineStatus;
  String oldPatientFree;
  String newPatientFree;
  String reportPatientFree;
  String id;

  factory DoctorFree.fromJson(Map<String, dynamic> json) => DoctorFree(
        day: json["day"],
        onlineStatus: json["online_status"],
        oldPatientFree: json["old_patient_free"],
        newPatientFree: json["new_patient_free"],
        reportPatientFree: json["report_patient_free"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "online_status": onlineStatus,
        "old_patient_free": oldPatientFree,
        "new_patient_free": newPatientFree,
        "report_patient_free": reportPatientFree,
        "id": id,
      };
}
