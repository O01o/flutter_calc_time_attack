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

import 'package:flutter_calc_time_attack/utils/switch_choice.dart';

class CalcTimeAttackScreen extends ConsumerWidget {
  CalcTimeAttackScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  int _counter = 0;
  SwitchChoice _switchChoice = SwitchChoice.a;

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

  Stream<int> time = Stream.periodic(Duration(seconds: 1)); 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: ref.watch(issueDataListProvider.future),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Text("data is null");
          } else {
            int index = _counter + 1;
            List<IssueData> issueDataList = snapshot.data!;
            if (issueDataList.isEmpty) {
              return const Text("no FileSystemEntity exists");
            } else {
              IssueData issueData = issueDataList[_counter];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$index問目',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(issueData.issue, 
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(issueData.formula,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    /*
                    ListTile(
                      title: Text(issueData.a),
                      leading: Radio(
                        value: SwitchChoice.a,
                        groupValue: _switchChoice,
                        onChanged: (SwitchChoice? value) {
                          setState(() { _switchChoice = value!; });
                        }
                      ),
                    ),
                    ListTile(
                      title: Text(issueData.b),
                      leading: Radio(
                        value: SwitchChoice.b,
                        groupValue: _switchChoice,
                        onChanged: (SwitchChoice? value) {
                          setState(() { _switchChoice = value!; });
                        }
                      ),
                    ),
                    ListTile(
                      title: Text(issueData.c),
                      leading: Radio(
                        value: SwitchChoice.c,
                        groupValue: _switchChoice,
                        onChanged: (SwitchChoice? value) {
                          setState(() { _switchChoice = value!; });
                        }
                      ),
                    ),
                    ListTile(
                      title: Text(issueData.d),
                      leading: Radio(
                        value: SwitchChoice.d,
                        groupValue: _switchChoice,
                        onChanged: (SwitchChoice? value) {
                          setState(() { _switchChoice = value!; });
                        }
                      ),
                    ),
                    ElevatedButton(
                      child: const Text("前の問題へ"),
                      onPressed: () {
                        setState(() {
                          if (_counter == 0) { _counter = issueDataList.length - 1; }
                          else { _counter--; }
                        });
                      }
                    ),
                    ElevatedButton(
                      child: const Text("次の問題へ"),
                      onPressed: () {
                        setState(() {
                            if (_counter >= issueDataList.length - 1) { _counter = 0; }
                            else { _counter++; }
                        });
                      }
                    ),
                    */
                    ElevatedButton(
                      child: const Text("問題を終了する"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("アプリを終了しますか？"),
                          content: const Text(""),
                          actions: [
                            ElevatedButton(
                              child: const Text("いいえ"),
                              onPressed: () => Navigator.pop(context, 'continue'),
                            ),
                            ElevatedButton(
                              child: const Text("はい"),
                              onPressed: () => Navigator.pushNamed(context, "/score"),
                            ),
                          ],
                        )
                      )
                    )
                  ],
                )
              );
            }
          }
        }
      )
    );
  }
}
