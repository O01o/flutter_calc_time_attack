import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/model/issue_data_provider.dart';

import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path_provider/path_provider.dart';

class ScoreScreen extends ConsumerWidget {
  ScoreScreen({Key? key, required this.title, required this.issueDataList, required this.time}) : super(key: key);

  final String title;
  final List<IssueData> issueDataList;
  final int time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double scorePercent = 0;
    for (IssueData issueData in issueDataList) {
      if (issueData.answerIndex == issueData.yourAnswerIndex) {
        scorePercent += 1;
      }
    }
    scorePercent /= issueDataList.length;
    scorePercent *= 100;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                IssueData issueData = issueDataList[index];
                return Card(
                  child: ListTile(
                    title: Text("${issueData.issue}, ${issueData.formula}"),
                    subtitle: Column(
                      children: [
                        Text("a: ${issueData.a}  b: ${issueData.b}  c: ${issueData.c}  d: ${issueData.d}"),
                        Text("answer_index: ${issueData.answerIndex.toString()}  your_answer_index: ${issueData.yourAnswerIndex.toString()}")
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
                // Image.asset('assets/images/Miku.png'),
                ElevatedButton(
                  child: const Text("トップに戻る"),
                  onPressed: () {
                    int randInt = Random().nextInt(3);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("今回のコラム"),
                        content: Image.asset('assets/images/trivia_$randInt.png'),
                        actions: [
                          ElevatedButton(
                            child: const Text("終了"),
                            onPressed: () { 
                              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                            },
                          ),
                        ],
                      )
                    );
                  }
                ),
              ]
            )
          ),
        ],
      )
    );
  }
}
