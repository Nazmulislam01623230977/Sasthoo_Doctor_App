// To parse this JSON data, do
//
//     final offilleDoctorFree = offilleDoctorFreeFromJson(jsonString);

import 'dart:convert';

List<OffilleDoctorFree> offilleDoctorFreeFromJson(String str) =>
    List<OffilleDoctorFree>.from(
        json.decode(str).map((x) => OffilleDoctorFree.fromJson(x)));

String offilleDoctorFreeToJson(List<OffilleDoctorFree> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OffilleDoctorFree {
  OffilleDoctorFree({
    this.id,
    this.chamberName,
    this.description,
    this.address,
    this.lat,
    this.lng,
    this.avater,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.shedulesfordoctors,
  });

  int id;
  String chamberName;
  String description;
  String address;
  dynamic lat;
  dynamic lng;
  String avater;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Shedulesfordoctor> shedulesfordoctors;

  factory OffilleDoctorFree.fromJson(Map<String, dynamic> json) =>
      OffilleDoctorFree(
        id: json["id"],
        chamberName: json["chamber_name"],
        description: json["description"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        avater: json["avater"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shedulesfordoctors: List<Shedulesfordoctor>.from(
            json["shedulesfordoctors"]
                .map((x) => Shedulesfordoctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chamber_name": chamberName,
        "description": description,
        "address": address,
        "lat": lat,
        "lng": lng,
        "avater": avater,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shedulesfordoctors":
            List<dynamic>.from(shedulesfordoctors.map((x) => x.toJson())),
      };
}

class Shedulesfordoctor {
  Shedulesfordoctor({
    this.id,
    this.userId,
    this.chamberId,
    this.day,
    this.startTime,
    this.endTime,
    this.patientLimit,
    this.intervalTime,
    this.onlineStatus,
    this.emergency,
    this.createdAt,
    this.updatedAt,
    this.doctorfees,
  });

  int id;
  String userId;
  String chamberId;
  String day;
  String startTime;
  String endTime;
  String patientLimit;
  String intervalTime;
  String onlineStatus;
  dynamic emergency;
  DateTime createdAt;
  DateTime updatedAt;
  List<Doctorfee> doctorfees;

  factory Shedulesfordoctor.fromJson(Map<String, dynamic> json) =>
      Shedulesfordoctor(
        id: json["id"],
        userId: json["user_id"],
        chamberId: json["chamber_id"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        patientLimit: json["patient_limit"],
        intervalTime: json["interval_time"],
        onlineStatus: json["online_status"],
        emergency: json["emergency"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctorfees: List<Doctorfee>.from(
            json["doctorfees"].map((x) => Doctorfee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "chamber_id": chamberId,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "patient_limit": patientLimit,
        "interval_time": intervalTime,
        "online_status": onlineStatus,
        "emergency": emergency,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "doctorfees": List<dynamic>.from(doctorfees.map((x) => x.toJson())),
      };
}

class Doctorfee {
  Doctorfee({
    this.id,
    this.userId,
    this.schedulId,
    this.onlineStatus,
    this.oldPatientFree,
    this.newPatientFree,
    this.reportPatientFree,
    this.chamberName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String userId;
  String schedulId;
  String onlineStatus;
  String oldPatientFree;
  String newPatientFree;
  String reportPatientFree;
  String chamberName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Doctorfee.fromJson(Map<String, dynamic> json) => Doctorfee(
        id: json["id"],
        userId: json["user_id"],
        schedulId: json["schedul_id"],
        onlineStatus: json["online_status"],
        oldPatientFree: json["old_patient_free"],
        newPatientFree: json["new_patient_free"],
        reportPatientFree: json["report_patient_free"],
        chamberName: json["chamber_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "schedul_id": schedulId,
        "online_status": onlineStatus,
        "old_patient_free": oldPatientFree,
        "new_patient_free": newPatientFree,
        "report_patient_free": reportPatientFree,
        "chamber_name": chamberName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
