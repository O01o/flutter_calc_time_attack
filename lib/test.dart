import 'dart:io';
import 'dart:convert';
// import 'package:flutter_calc_time_attack/model/issue_data.dart';

void main() {
  print("Hello world!!");
  String path = "./data/issue_data.json";
  if (FileSystemEntity.isDirectorySync(path)) {
    print("path is directory");
  } else {
    final issueData = File(path);
    String issueDataString = issueData.readAsStringSync();
    List issueDataList = issueDataString.split("\n");
    int index = 0;
    issueDataList.forEach((data) {
      data = data.trim();
      if (index != 0 && index != issueDataList.length - 1) {
        int dataLength = data.length - 1;
        if (data[dataLength] != "}") {
          data = data.toString().substring(0, dataLength);
        } else {
          data = data.toString();
        }
        data = json.decode(data);
        print(data["issue"]);
      }
      index++;
    });
  }
}