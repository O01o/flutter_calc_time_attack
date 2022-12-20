import 'dart:io';
import 'dart:convert';
import 'package:flutter_calc_time_attack/data/json_list_decoder.dart';

// import 'package:flutter_calc_time_attack/model/issue_data.dart';

void main() {
  print("Hello world!!");
  List<Map<String, dynamic>> jsonListMap = jsonListDecoder(issueDataPath);
  int jsonListMapLength = jsonListMap.length;
  print("len: $jsonListMapLength");
  jsonListMap.forEach((element) {
    print(element["answer"]);
  });
}