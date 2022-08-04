import 'dart:convert';

TotalAmount totalAmountFromJson(String str) =>
    TotalAmount.fromJson(json.decode(str));

String totalAmountToJson(TotalAmount data) => json.encode(data.toJson());

class TotalAmount {
  TotalAmount({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  List<dynamic> msg;
  int data;

  factory TotalAmount.fromJson(Map<String, dynamic> json) => TotalAmount(
        status: json["status"],
        msg: List<dynamic>.from(json["msg"].map((x) => x)),
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": List<dynamic>.from(msg.map((x) => x)),
        "data": data,
      };
}
