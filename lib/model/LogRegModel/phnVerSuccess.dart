// class AutogeneratedS {
//   String requestType;
//   String campaignUid;
//   String smsUid;
//   List<Null> invalidNumbers;
//   int apiResponseCode;
//   String apiResponseMessage;

//   AutogeneratedS(
//       {this.requestType,
//       this.campaignUid,
//       this.smsUid,
//       this.invalidNumbers,
//       this.apiResponseCode,
//       this.apiResponseMessage});

//   AutogeneratedS.fromJson(Map<String, dynamic> json) {
//     requestType = json['request_type'];
//     campaignUid = json['campaign_uid'];
//     smsUid = json['sms_uid'];
//     if (json['invalid_numbers'] != null) {
//       invalidNumbers = <Null>[];
//       json['invalid_numbers'].forEach((v) {
//           //invalidNumbers.add(new Null.fromJson(v));
//       });
//     }
//     apiResponseCode = json['api_response_code'];
//     apiResponseMessage = json['api_response_message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['request_type'] = this.requestType;
//     data['campaign_uid'] = this.campaignUid;
//     data['sms_uid'] = this.smsUid;
//     if (this.invalidNumbers != null) {
//       data['invalid_numbers'] =
//         //  this.invalidNumbers.map((v) => v.toJson()).toList();
//     }
//     data['api_response_code'] = this.apiResponseCode;
//     data['api_response_message'] = this.apiResponseMessage;
//     return data;
//   }
// }