import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:path_provider/path_provider.dart';


Future<String> path = rootBundle.loadString('assets/data/issue_data.json');

final calendarJsonStringProvider = FutureProvider<String>((ref) async {
  return rootBundle.loadString('assets/data/calendar_stamp.json');
});

final calendarDataListProvider = FutureProvider<Map<String, int>>((ref) async {
  Directory directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> fileSystemEntityList = directory.listSync();
  // List<IssueData> issueDataList;
  print("file system entity list: $fileSystemEntityList");
  Map<String, int> jsonMap = {};
  
  if (fileSystemEntityList.isEmpty) {
    print("Load from asset data...");
    String sampleData = await ref.watch(calendarJsonStringProvider.future);
    jsonMap = json.decode(sampleData);
  } else {
    print("Load from ApplicationDocumentDirectory...");
    fileSystemEntityList.forEach((fileSystemEntity) {
      if (fileSystemEntity is File) {
        String jsonString = fileSystemEntity.readAsStringSync();
        jsonMap = json.decode(jsonString);
      }
    });
  }

  return jsonMap;
});