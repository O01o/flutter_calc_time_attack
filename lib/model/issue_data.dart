// This file is "main.dart"
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_calc_time_attack/utils/switch_choice.dart';


part 'issue_data.freezed.dart';
part 'issue_data.g.dart';

@freezed
class IssueData with _$IssueData {
  const factory IssueData({
    required String issue,
    required String formula,
    required String a,
    required String b,
    required String c,
    required String d,
    required int answerIndex,
    required int yourAnswerIndex
  }) = _IssueData;

    factory IssueData.fromJson(Map<String, dynamic> json)
    => _$IssueDataFromJson(json);
}

final timerCounterProvider = StreamProvider<int>((ref) async* {
  int time = 0;

  while (true) {
    await Future.delayed(Duration(seconds: 1));
    time++;
    yield time;
  }
});

final issueJsonStringProvider = FutureProvider<String>((ref) async {
  return rootBundle.loadString('assets/data/issue_data.json');
});


final issueDataListProvider = FutureProvider<List<IssueData>>((ref) async {
Directory directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> fileSystemEntityList = directory.listSync();
  // List<IssueData> issueDataList;
  List<IssueData> issueDataList = [];
  print("file system entity list: $fileSystemEntityList");
  
  if (fileSystemEntityList.isEmpty) {
    print("Load from asset data...");
    String sampleData = await ref.watch(issueJsonStringProvider.future);
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
});


final IssueDataListNotifierProvider = StateNotifierProvider<IssueDataListNotifier, List<IssueData>>((ref) {
  return IssueDataListNotifier();
});


class IssueDataListNotifier extends StateNotifier<List<IssueData>> {
  IssueDataListNotifier(): super([]);

  void answer(List<IssueData> issueData, int index, SwitchChoice switchChoice) {
    state = [
      if (switchChoice == SwitchChoice.a) state[index].copyWith(yourAnswerIndex: 0)
      else if (switchChoice == SwitchChoice.b) state[index].copyWith(yourAnswerIndex: 1)
      else if (switchChoice == SwitchChoice.c) state[index].copyWith(yourAnswerIndex: 2)
      else if (switchChoice == SwitchChoice.d) state[index].copyWith(yourAnswerIndex: 3)
    ];
  }
}