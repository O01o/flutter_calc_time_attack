import 'package:flutter/material.dart';

import 'package:flutter_calc_time_attack/model/issue_data.dart';
import 'package:flutter_calc_time_attack/widgets/score.dart';

import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_calc_time_attack/utils/switch_choice.dart';

class CalcTimeAttackScreen extends ConsumerWidget {
  const CalcTimeAttackScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexNotifierProvider);
    final switchChoice = ref.watch(switchChoiceProvider);
    int time = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: ref.watch(issueDataListFutureProvider.future),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // List<IssueData> issueDataList = snapshot.data!;
            List<IssueData> issueDataList = ref.watch(issueDataListNotifierProvider);
            if (issueDataList.isEmpty) {
              return Center(
                child: ElevatedButton(
                  child: const Text("start"),
                  onPressed: () {
                    ref.watch(issueDataListNotifierProvider.notifier).state = snapshot.data!;
                  },
                ),
              );
            } else {
                IssueData issueData = issueDataList[ref.watch(indexNotifierProvider)];
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        StreamBuilder(
                          stream: ref.watch(timerStreamProvider.stream),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              time = snapshot.data!;
                              int hours = time ~/ 3600;
                              int minutes = (time % 3600) ~/ 60;
                              int seconds = time % 60;
                              return Text("経過時間: $hours時間 $minutes分 $seconds秒");  
                            } else {
                              return const Center(
                                child: CircularProgressIndicator()
                              );
                            }
                          }
                        ),
                        Text("${index + 1}問目"),
                        Text(issueData.issue),
                        Text(issueData.formula),
                        RadioListTile(
                          title: Text(issueData.a),
                          value: SwitchChoice.a,
                          groupValue: switchChoice,
                          onChanged: (_) {
                            ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.a);
                            ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.a;
                          },
                        ),
                        RadioListTile(
                          title: Text(issueData.b),
                          value: SwitchChoice.b,
                          groupValue: switchChoice,
                          onChanged: (_) {
                            ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.b);
                            ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.b;
                          }
                        ),
                        RadioListTile(
                          title: Text(issueData.c),
                          value: SwitchChoice.c,
                          groupValue: switchChoice,
                          onChanged: (_) {
                            ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.c);
                            ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.c;
                          }
                        ),
                        RadioListTile(
                          title: Text(issueData.d),
                          value: SwitchChoice.d,
                          groupValue: switchChoice,
                          onChanged: (_) {
                            ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.d);
                            ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.d;
                          }
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              child: const Text("前の問題へ"),
                              onPressed: () {
                                ref.watch(indexNotifierProvider.notifier).decrement(issueDataList.length);
                                // ref.watch(switchChoiceProvider.notifier).switching(issueDataList[index].yourAnswerIndex);
                                print("index: $index, ${ref.watch(indexNotifierProvider)}");
                                print("yourAnswerIndex: ${issueDataList[index].yourAnswerIndex}");
                                // ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.none;
                                ref.watch(switchChoiceProvider.notifier).switching(issueDataList[ref.watch(indexNotifierProvider)].yourAnswerIndex);
                              }
                            ),
                            const Spacer(flex: 1),
                            ElevatedButton(
                              child: const Text("次の問題へ"),
                              onPressed: () {
                                print(issueDataList.length);
                                ref.watch(indexNotifierProvider.notifier).increment(issueDataList.length);
                                // ref.watch(switchChoiceProvider.notifier).switching(issueDataList[index].yourAnswerIndex);
                                print("index: $index, ${ref.watch(indexNotifierProvider)}");
                                print("yourAnswerIndex: ${issueDataList[index].yourAnswerIndex}");
                                // ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.none;
                                ref.watch(switchChoiceProvider.notifier).switching(issueDataList[ref.watch(indexNotifierProvider)].yourAnswerIndex);
                              }
                            ),
                          ],
                        ),
                        ElevatedButton(
                          child: const Text("問題を終了する"),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("問題を終了しますか？"),
                              content: const Text(""),
                              actions: [
                                ElevatedButton(
                                  child: const Text("いいえ"),
                                  onPressed: () { Navigator.pop(context, 'continue'); },
                                ),
                                ElevatedButton(
                                  child: const Text("はい"),
                                  onPressed: () { 
                                    ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.none;
                                    // jsonifyIssueDataList(issueDataList, getApplicationDocumentsDirectory(), "issue_data.json");
                                    Navigator.pushAndRemoveUntil(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => ScoreScreen(title: title, issueDataList: issueDataList, time: time)), 
                                      (route) => false);
                                  },
                                ),
                              ],
                            )
                          )
                        )
                      ]
                    )
                  )
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          } 
        }
      )
    );
  }
}