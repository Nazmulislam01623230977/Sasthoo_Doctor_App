// To parse this JSON data, do
//
//     final profilesheduleList = profilesheduleListFromJson(jsonString);

import 'dart:convert';

List<ProfilesheduleList> profilesheduleListFromJson(String str) =>
    List<ProfilesheduleList>.from(
        json.decode(str).map((x) => ProfilesheduleList.fromJson(x)));

String profilesheduleListToJson(List<ProfilesheduleList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfilesheduleList {
  ProfilesheduleList({
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
    this.schedule,
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
  List<Schedule> schedule;

  factory ProfilesheduleList.fromJson(Map<String, dynamic> json) =>
      ProfilesheduleList(
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
        schedule: List<Schedule>.from(
            json["schedule"].map((x) => Schedule.fromJson(x))),
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
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      };
}

class Schedule {
  Schedule({
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
    this.activeStatus,
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
  String activeStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<Doctorfee> doctorfees;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
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
        activeStatus: json["active_status"],
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
        "active_status": activeStatus,
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
