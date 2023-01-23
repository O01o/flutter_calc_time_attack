import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';


Future<String> path = rootBundle.loadString('assets/data/issue_data.json');

final calendarJsonStringProvider = FutureProvider<String>((ref) async {
  return rootBundle.loadString('assets/data/calendar_stamp.json');
});

final calendarStampFutureProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  String calendarStampString = await rootBundle.loadString('assets/data/calendar_stamp.json');
  final jsonMap = json.decode(calendarStampString);
  
  /*
  Directory directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> fileSystemEntityList = directory.listSync();
  print("file system entity list: $fileSystemEntityList");
  
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
  */

  return jsonMap;
});


void jsonifyCalendarStamp(Map<String, dynamic> jsonMap, String dateString, int time, Future<Directory> path, String fileName) {
  jsonMap[dateString] = time;
  String jsonString = json.encode(jsonMap);
  var jsonFile = File(fileName);
  jsonFile.writeAsStringSync(jsonString);
}


final selectedDayStateProvider = StateProvider.autoDispose<DateTime>((ref) => DateTime.now());


final focusedDayStateProvider = StateProvider.autoDispose<DateTime>((ref) => DateTime.now());







