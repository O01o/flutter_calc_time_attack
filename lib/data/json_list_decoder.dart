import 'dart:io';
import 'dart:convert';

// import 'package:flutter_calc_time_attack/model/issue_data.dart';

String issueDataPath = "./issue_data.json";

List<Map<String, dynamic>> jsonListDecoder(String path) {
  print("Hello world!!");
  if (FileSystemEntity.isDirectorySync(path)) {
    print("path is directory");
    
    return [];
  } else {
    String jsonString = File(path).readAsStringSync();
    List jsonListString = jsonString.split("\n");
    List<Map<String, dynamic>> jsonListMap = [];
    
    int index = 0;
    jsonListString.forEach((data) {
      data = data.trim();
      if (index != 0 && index != jsonListString.length - 1) {
        int dataLength = data.length - 1;
        if (data[dataLength] != "}") {
          data = data.toString().substring(0, dataLength);
        } else {
          data = data.toString();
        }
        data = json.decode(data);
        jsonListMap.add(data);
        // final issue = IssueData.fromJson(json.decode(data));
        // issueDataListFreezed.add(issue);
      }
      index++;
    });
    
    return jsonListMap;
  }
}