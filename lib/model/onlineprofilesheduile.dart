// To parse this JSON data, do
//
//     final profileonlinesheduleList = profileonlinesheduleListFromJson(jsonString);

import 'dart:convert';

List<ProfileonlinesheduleList> profileonlinesheduleListFromJson(String str) =>
    List<ProfileonlinesheduleList>.from(
        json.decode(str).map((x) => ProfileonlinesheduleList.fromJson(x)));

String profileonlinesheduleListToJson(List<ProfileonlinesheduleList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileonlinesheduleList {
  ProfileonlinesheduleList({
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
  });

  int id;
  String userId;
  dynamic chamberId;
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

  factory ProfileonlinesheduleList.fromJson(Map<String, dynamic> json) =>
      ProfileonlinesheduleList(
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
      };
}
