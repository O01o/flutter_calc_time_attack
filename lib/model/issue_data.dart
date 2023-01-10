// This file is "main.dart"
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:html';
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


final indexProvider = StateProvider<int>((ref) => 0);


final indexNotifierProvider = StateNotifierProvider<IndexNotifier, int>((ref) {
  return IndexNotifier(ref);
});

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier(ref): super(0);

  void increment(int length) {
    if (state >= length - 1) { state = 0; }
    else { state++; }
  }

  void decrement(int length) {
    if (state == 0) { state = length -1; }
    else { state--; }
  }
}


final switchChoiceProvider = StateProvider<SwitchChoice>((ref) => SwitchChoice.a);


final issueDataListNotifierProvider = StateNotifierProvider<IssueDataListNotifier, List<IssueData>>((ref) {
  return IssueDataListNotifier(ref);
});

class IssueDataListNotifier extends StateNotifier<List<IssueData>> {
  IssueDataListNotifier(ref): super(ref.watch(issueDataListProvider.future));

  void answer(int index, SwitchChoice switchChoice) {
    if (switchChoice == SwitchChoice.a) { state[index].copyWith(yourAnswerIndex: 0); }
    else if (switchChoice == SwitchChoice.b) { state[index].copyWith(yourAnswerIndex: 1); }
    else if (switchChoice == SwitchChoice.c) { state[index].copyWith(yourAnswerIndex: 2); }
    else if (switchChoice == SwitchChoice.d) { state[index].copyWith(yourAnswerIndex: 3); }
  }
}

void finish(List<IssueData> issueDataList, Future<Directory> path, String fileName) {
  String jsonString = "[]";
  List<String> jsonList = [];
  for (IssueData issueData in issueDataList) {
    // IssueData.toJson so convert to string, and add to jsonList
    Map<String, dynamic> jsonMap = issueData.toJson();
    jsonList.add(json.encode(jsonMap));
  }
  // just join with ''.join(issueList, ", ")
  jsonString = "[" + jsonList.join(", ") + "]";
  
}