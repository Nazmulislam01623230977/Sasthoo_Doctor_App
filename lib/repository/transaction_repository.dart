import '../api/apitoken.dart';
import '../api/apiurl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/onlineprofilesheduile.dart';
import '../model/total_amount.dart';
import '../model/transaction_models.dart';

class TransactionListService {
  Future<List<Transcation>> transactionrepository() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.transactionlist + userdata['id'].toString();
      var apiurl = Uri.parse(url);
      var response = await client.get(
        apiurl,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        var jsonMap = jsonDecode(json);
        var jsondata = jsonMap['data'];
        var jsondataencod = jsonEncode(jsondata);
        return transcationFromJson(jsondataencod);
      }
    } on Exception {
      return null;
    }
  }

  Future<TotalAmount> totalamount() async {
    var client = http.Client();
    try {
      await userdataget();
      var url = ApiRepo.totalamount + userdata['id'].toString();
      var apiurl = Uri.parse(url);
      var response = await client.get(
        apiurl,
        headers: headerValue,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        // var jsonMap = jsonDecode(json);
        // var jsondata = jsonMap['data'];
        // var jsondataencod = jsonEncode(json);
        return totalAmountFromJson(json);
      }
    } on Exception {
      return null;
    }
  }
}
