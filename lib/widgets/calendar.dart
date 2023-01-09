import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/model/issue_data.dart';

import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerWidget {
  CalendarScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  int _counter = 0;

  /*
  Future<String> get _issueJsonString async {
    // return rootBundle.loadString('assets/data/sample_data.json');
    return rootBundle.loadString('assets/data/issue_data.json');
  }

  Future<List<IssueData>> get _issueDataList async {
    Directory directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileSystemEntityList = directory.listSync();
    // List<IssueData> issueDataList;
    List<IssueData> issueDataList = [];
    print("file system entity list: $fileSystemEntityList");
    
    if (fileSystemEntityList.isEmpty) {
      print("Load from asset data...");
      String sampleData = await _issueJsonString;
      List<dynamic> jsonMapList = json.decode(sampleData);
      for (Map<String, dynamic> element in jsonMapList) {
        issueDataList.add(IssueData.fromJson(element));
      }
    } else {
      print("Load from ApplicationDocumentDirectory...");
      fileSystemEntityList.forEach((fileSystemEntity) {
        if (fileSystemEntity is File) {
          String jsonString = fileSystemEntity.readAsStringSync();
          List<dynamic> jsonMapList = json.decode(jsonString);
          for (Map<String, dynamic> element in jsonMapList) {
            issueDataList.add(IssueData.fromJson(element));
          }
        }
      });
    }
    
    return issueDataList;
  }
  */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime.utc(now.year-50, 1, 1);
    DateTime lastDay = DateTime.utc(now.year+50, 12, 31);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TableCalendar(
        focusedDay: now,
        firstDay: firstDay,
        lastDay: lastDay
      )
    );
  }
}
