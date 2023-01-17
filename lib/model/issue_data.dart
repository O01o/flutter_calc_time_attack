import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path_provider/path_provider.dart';
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

final issueJsonStringProvider = FutureProvider<String>((ref) async {
  return rootBundle.loadString('assets/data/issue_data.json');
});


void jsonifyIssueDataList(List<IssueData> issueDataList, Future<Directory> path, String fileName) {
  List<String> jsonList = [];
  for (IssueData issueData in issueDataList) {
    Map<String, dynamic> jsonMap = issueData.toJson();
    jsonList.add(json.encode(jsonMap));
  }
  String jsonString = "[${jsonList.join(", ")}]";
  var jsonFile = File(fileName);
  // jsonFile.writeAsStringSync(jsonString);
}


final issueDataListFutureProvider = FutureProvider.autoDispose<List<IssueData>>((ref) async {
  List<IssueData> issueDataList = [];
  // only asset load, it discribes below.
  String sampleData = await rootBundle.loadString('assets/data/issue_data.json');
  List<dynamic> jsonMapList = json.decode(sampleData);
  for (Map<String, dynamic> element in jsonMapList) {
    issueDataList.add(IssueData.fromJson(element));
  }
  // accept both getApplicationDocumentDirectory and Asset data, just below.
  /*
  Directory directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> fileSystemEntityList = directory.listSync();
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
    for (var fileSystemEntity in fileSystemEntityList) {
      if (fileSystemEntity is File) {
        String jsonString = fileSystemEntity.readAsStringSync();
        List<dynamic> jsonMapList = json.decode(jsonString);
        for (Map<String, dynamic> element in jsonMapList) {
          issueDataList.add(IssueData.fromJson(element));
        }
      }
    }
  }
  */
  return issueDataList;
});


final issueDataListNotifierProvider = StateNotifierProvider.autoDispose<IssueDataListNotifier, List<IssueData>>((ref) {
  return IssueDataListNotifier(ref);
});


class IssueDataListNotifier extends StateNotifier<List<IssueData>> {
  IssueDataListNotifier(ref): super([]);

  void answer(int index, SwitchChoice switchChoice) {
    print("${state.runtimeType}");
    state = [
      for (int i=0; i<state.length; i++)
        if (i == index && switchChoice == SwitchChoice.a) state[i].copyWith(yourAnswerIndex: 0)
        else if (i == index && switchChoice == SwitchChoice.b) state[i].copyWith(yourAnswerIndex: 1)
        else if (i == index && switchChoice == SwitchChoice.c) state[i].copyWith(yourAnswerIndex: 2)
        else if (i == index && switchChoice == SwitchChoice.d) state[i].copyWith(yourAnswerIndex: 3)
        else state[i]
    ];
    
    for (final element in state) {
      print("${element.formula}, ${element.yourAnswerIndex}");
    }
  }
}


final indexNotifierProvider = StateNotifierProvider.autoDispose<IndexNotifier, int>((ref) {
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


final switchChoiceProvider = StateNotifierProvider<SwitchChoiceNotifier, SwitchChoice>((ref) {
  return SwitchChoiceNotifier(ref);
});

class SwitchChoiceNotifier extends StateNotifier<SwitchChoice> {
  SwitchChoiceNotifier(ref): super(SwitchChoice.none);

  void switching(int yourAnswerIndex) {
      if (yourAnswerIndex == 0) { state = SwitchChoice.a; }
      else if (yourAnswerIndex == 1) { state = SwitchChoice.b; }
      else if (yourAnswerIndex == 2) { state = SwitchChoice.c; }
      else if (yourAnswerIndex == 3) { state = SwitchChoice.d; }
      else { state = SwitchChoice.none; }
  }
}


final timerStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  int time = 0;

  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    time++;
    yield time;
  }
});