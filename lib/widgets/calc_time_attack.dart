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
  const CalcTimeAttackScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issueDataList = ref.watch(issueDataListNotifierProvider);
    final index = ref.watch(indexNotifierProvider);
    final problemIndex = ref.watch(indexProvider) + 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CustomScrollView(
        slivers: [
          ListView(
            children: [
              StreamBuilder(
                stream: ref.watch(timerCounterProvider.stream),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  int time = snapshot.data!;
                  int hours = time ~/ 3600;
                  int minutes = (time % 3600) ~/ 60;
                  int seconds = time % 60;
                  return Text("経過時間: $hours時間 $minutes分 $seconds秒");
                }
              ),
              Text(
                "$problemIndex問目", 
                style: Theme.of(context).textTheme.headline4
              ),
              Text(
                issueDataList[index].issue, 
                style: Theme.of(context).textTheme.headline5
              ),
              Text(
                issueDataList[index].formula,
                style: Theme.of(context).textTheme.headline4
              ),
              RadioListTile(
                title: Text('a: ' + issueDataList[index].a),
                value: SwitchChoice.a,
                groupValue: ref.watch(switchChoiceProvider),
                onChanged: (value) {
                  ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.a;
                  ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.a);
                }
              ),
              RadioListTile(
                title: Text('b: ' + issueDataList[index].b),
                value: SwitchChoice.b,
                groupValue: ref.watch(switchChoiceProvider),
                onChanged: (value) {
                  ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.b;
                  ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.b);
                }
              ),
              RadioListTile(
                title: Text('c: ' + issueDataList[index].c),
                value: SwitchChoice.c,
                groupValue: ref.watch(switchChoiceProvider),
                onChanged: (value) {
                  ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.c;
                  ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.c);
                }
              ),
              RadioListTile(
                title: Text('d: ' + issueDataList[index].d),
                value: SwitchChoice.d,
                groupValue: ref.watch(switchChoiceProvider),
                onChanged: (value) {
                  ref.watch(switchChoiceProvider.notifier).state = SwitchChoice.d;
                  ref.watch(issueDataListNotifierProvider.notifier).answer(index, SwitchChoice.d);
                }
              ),
              ElevatedButton(
                child: const Text("前の問題へ"),
                onPressed: () => ref.watch(indexNotifierProvider.notifier).decrement(issueDataList.length)
              ),
              ElevatedButton(
                child: const Text("次の問題へ"),
                onPressed: () => ref.watch(indexNotifierProvider.notifier).increment(issueDataList.length)
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
                          finish(issueDataList, getApplicationDocumentsDirectory(), "issue_data.json");
                          Navigator.pushNamed(context, "/score");
                        },
                      ),
                    ],
                  )
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
