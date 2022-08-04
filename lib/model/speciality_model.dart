import 'dart:convert';

List<Speicality> speicalityFromJson(String str) =>
    List<Speicality>.from(json.decode(str).map((x) => Speicality.fromJson(x)));

String speicalityToJson(List<Speicality> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Speicality {
  Speicality({
    this.id,
    this.specialitie,
    this.subSpecialitie,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String specialitie;
  String subSpecialitie;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Speicality.fromJson(Map<String, dynamic> json) => Speicality(
        id: json["id"],
        specialitie: json["specialitie"],
        subSpecialitie: json["sub_specialitie"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specialitie": specialitie,
        "sub_specialitie": subSpecialitie,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
