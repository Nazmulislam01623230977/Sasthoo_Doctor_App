// To parse this JSON data, do
//
//     final sheduleList = sheduleListFromJson(jsonString);

import 'dart:convert';

List<SheduleList> sheduleListFromJson(String str) => List<SheduleList>.from(
    json.decode(str).map((x) => SheduleList.fromJson(x)));

String sheduleListToJson(List<SheduleList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SheduleList {
  SheduleList({
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
    this.chambers,
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
  Chambers chambers;

  factory SheduleList.fromJson(Map<String, dynamic> json) => SheduleList(
        id: json["id"],
        userId: json["user_id"],
        chamberId: json["chamber_id"] == null ? null : json["chamber_id"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        patientLimit: json["patient_limit"],
        intervalTime: json["interval_time"],
        onlineStatus: json["online_status"],
        emergency: json["emergency"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        chambers: json["chambers"] == null
            ? null
            : Chambers.fromJson(json["chambers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "chamber_id": chamberId == null ? null : chamberId,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "patient_limit": patientLimit,
        "interval_time": intervalTime,
        "online_status": onlineStatus,
        "emergency": emergency,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "chambers": chambers == null ? null : chambers.toJson(),
      };
}

class Chambers {
  Chambers({
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

  factory Chambers.fromJson(Map<String, dynamic> json) => Chambers(
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
      };
}
