import 'dart:io';
import 'dart:convert';

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
      print("$index: $data");
      index++;
    });
  }
}