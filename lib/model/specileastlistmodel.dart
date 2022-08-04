// To parse this JSON data, do
//
//     final specialities = specialitiesFromJson(jsonString);

// import 'dart:convert';

// Specialities specialitiesFromJson(String str) =>
//     Specialities.fromJson(json.decode(str));

// String specialitiesToJson(Specialities data) => json.encode(data.toJson());

// class Specialities {
//   Specialities({
//     this.status,
//     this.msg,
//     this.result,
//   });

//   String status;
//   List<dynamic> msg;
//   List<Result> result;

//   factory Specialities.fromJson(Map<String, dynamic> json) => Specialities(
//         status: json["status"],
//         msg: List<dynamic>.from(json["msg"].map((x) => x)),
//         result:
//             List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": List<dynamic>.from(msg.map((x) => x)),
//         "result": List<dynamic>.from(result.map((x) => x.toJson())),
//       };
// }

// class Result {
//   Result({
//     this.id,
//     this.specialitie,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String specialitie;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         specialitie: json["specialitie"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "specialitie": specialitie,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }Staff
class Specilestlist {
  String stitle;
  String subtitle;

  Specilestlist({
    this.stitle,
    this.subtitle,
  });
}

List<Specilestlist> specialist = [
  Specilestlist(
    stitle: 'aaaaa',
    subtitle: 'hnh',
  ),
  Specilestlist(
    stitle: 'hcfhbv',
    subtitle: 'cvvhn',
  ),
  Specilestlist(
    stitle: 'gvbng',
    subtitle: 'vbnn',
  ),
];
