import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/model/issue_data.dart';

import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int _counter = 0;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _issueDataList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<IssueData> issueDataList = snapshot.data!;
          
          double scorePercent = 0;
          for (IssueData issueData in issueDataList) {
            if (issueData.answerIndex == issueData.yourAnswerIndex) {
              scorePercent += 1;
            }
          }
          scorePercent /= issueDataList.length;
          scorePercent *= 100;

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ElevatedButton(
                      child: const Text("トップに戻る"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      }
                    ),
                    Text("正解率: $scorePercent %"),
                  ]
                )
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    IssueData issueData = issueDataList[index];
                    return Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(issueData.issue),
                            Text(issueData.formula)
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        subtitle: Column(
                          children: [
                            Text("a: " + issueData.a 
                            + "  b: " + issueData.b 
                            + "  c: " + issueData.c 
                            + "  d: " + issueData.d),
                            Text("answer: " + issueData.answerIndex.toString() 
                            + "  your_answer: " + issueData.yourAnswerIndex.toString())
                          ]
                        ),
                        tileColor: (issueData.answerIndex == issueData.yourAnswerIndex)
                        ? const Color.fromARGB(255, 200, 255, 200)
                        : const Color.fromARGB(255, 255, 200, 200),
                      )
                    );
                  },
                  childCount: issueDataList.length
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text("正解率: $scorePercent %"),
                    ElevatedButton(
                      child: const Text("トップに戻る"),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                      }
                    ),
                  ]
                )
              ),
            ],
          );
        },
      )
    );
  }
}
