import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tdp_flutter_project/models/ReportPrediction.dart';

Future<ReportPrediction?> getPredictionData() async {
  ReportPrediction? result;
  try{
    final response = await http.get(Uri.parse("https://fastapi-production-2d89.up.railway.app/prediction"),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = ReportPrediction.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}