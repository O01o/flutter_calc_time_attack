import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/data/json_list_decoder.dart';
import 'package:flutter_calc_time_attack/model/issue_data.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';
import 'dart:convert';

class CalcTimeAttackScreen extends StatefulWidget {
  const CalcTimeAttackScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<CalcTimeAttackScreen> createState() => _CalcTimeAttackScreenState();
}

class _CalcTimeAttackScreenState extends State<CalcTimeAttackScreen> {
  int _counter = 1;
  // List<Map<String, dynamic>> = ;

  Future<String> get _issueJsonString async {
    return rootBundle.loadString('assets/data/sample_data.json');
  }

  Future<List<IssueData>> get _issueDataList async {
    Directory directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileSystemEntityList = directory.listSync();
    List<IssueData> issueDataList = [];
    print("file system entity list: $fileSystemEntityList");
    
    if (fileSystemEntityList.isEmpty) {
      print("fse null course");
      // File sampleData = File('assets/data/issue_data.json');
      String sampleData = await _issueJsonString;
      print("next?");
      // IssueData issueData = jsonDecode(sampleData);
      Map<String, dynamic> jsonMap = json.decode(sampleData);
      print("next?");
      IssueData issueData = IssueData.fromJson(jsonMap);
      print("next?");
      issueDataList.add(issueData);
      print("next?");
    } else {
      fileSystemEntityList.forEach((element) {
        if (element is File) {
          IssueData issueData = IssueData.fromJson(json.decode(element.readAsStringSync()));
          issueDataList.add(issueData);
        }
      });
    }
    print("file system entity list: $fileSystemEntityList");
    
    return issueDataList;
  }

  @override
  void initState() {
    super.initState();
  }

  void _incrementIssueCounter() {
    setState(() {
      if (_counter >= 5) {
        _counter = 1;
      } else {
        _counter++;
      }
    });
  }

  void _decrementIssueCounter() {
    setState(() {
      if (_counter == 1) {
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
                    Text(issueData.a),
                    Text(issueData.b),
                    Text(issueData.c),
                    Text(issueData.d),
                    ElevatedButton(
                      child: const Text("前の問題へ"),
                      onPressed: _decrementIssueCounter
                    ),
                    ElevatedButton(
                      child: const Text("次の問題へ"),
                      onPressed: _incrementIssueCounter
                    ),
                    Radio(value: value, groupValue: groupValue, onChanged: onChanged)
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
