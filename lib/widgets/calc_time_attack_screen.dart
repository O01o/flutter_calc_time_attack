import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/model/issue_data.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';
import 'dart:convert';

enum SwitchChoice {
  a,
  b,
  c,
  d
}

class CalcTimeAttackScreen extends StatefulWidget {
  const CalcTimeAttackScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<CalcTimeAttackScreen> createState() => _CalcTimeAttackScreenState();
}

class _CalcTimeAttackScreenState extends State<CalcTimeAttackScreen> {
  int _counter = 0;
  SwitchChoice _switchChoice = SwitchChoice.a;

  Future<String> get _issueJsonString async {
    return rootBundle.loadString('assets/data/sample_data.json');
  }

  Future<List<IssueData>> get _issueDataList async {
    Directory directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileSystemEntityList = directory.listSync();
    List<IssueData> issueDataList = [];
    print("file system entity list: $fileSystemEntityList");
    
    if (fileSystemEntityList.isEmpty) {
      String sampleData = await _issueJsonString;
      Map<String, dynamic> jsonMap = json.decode(sampleData);
      IssueData issueData = IssueData.fromJson(jsonMap);
      issueDataList.add(issueData);
    } else {
      fileSystemEntityList.forEach((element) {
        if (element is File) {
          IssueData issueData = IssueData.fromJson(json.decode(element.readAsStringSync()));
          issueDataList.add(issueData);
        }
      });
    }
    
    return issueDataList;
  }

  @override
  void initState() {
    super.initState();
  }

  void _incrementIssueCounter() {
    setState(() {
      if (_counter >= 5) {
        _counter = 0;
      } else {
        _counter++;
      }
    });
  }

  void _decrementIssueCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 5;
      } else {
        _counter--;
      }
    });
  }

  void _toggleSwitching(int index) {
    setState(() {
      // _issueListFreezed[_counter].copyWith(yourAnswerIndex: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _issueDataList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Text("data is null");
          } else {
            List<IssueData> issueDataList = snapshot.data!;
            if (issueDataList.isEmpty) {
              return const Text("no FileSystemEntity exists");
            } else {
              IssueData issueData = issueDataList[_counter];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$_counter問目',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(issueData.issue),
                    Text(issueData.formula),
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
                      onPressed: _decrementIssueCounter
                    ),
                    ElevatedButton(
                      child: const Text("次の問題へ"),
                      onPressed: _incrementIssueCounter
                    ),
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
