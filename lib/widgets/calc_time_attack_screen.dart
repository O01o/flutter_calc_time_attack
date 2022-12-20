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
  int _counter = 0;
  // List<Map<String, dynamic>> = ;

  Future<String> get _issueJsonString async {
    return rootBundle.loadString('assets/data/issue_data.json');
  }

  Future<List<Map<String, dynamic>>> get _issueJsonListMap async {
    String issueJsonString = await _issueJsonString;
    List<Map<String, dynamic>> issueJsonListMap = json.decode(issueJsonString);
    print("issueJsonListMap: $issueJsonListMap");
    return issueJsonListMap;
  }

  @override
  void initState() {
    super.initState();

    int index = 0;
  }

  void _incrementIssueCounter() {
    setState(() {
      _counter++;
      /*
      if (_counter++ >= _issueListFreezed.length) {
        _counter = 0;
      } else {
        _counter++;
      }
      */
    });
  }

  void _decrementIssueCounter() {
    setState(() {
      _counter--;
      /*
      if (_counter-- < 0) {
        _counter = _issueListFreezed.length - 1;
      } else {
        _counter--;
      }
      */
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter問目',
              style: Theme.of(context).textTheme.headline4,
            ),
            
            FutureBuilder(
              future: _issueJsonString,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return const Text("data loading...");
                }
              }
            ),
            
            FutureBuilder(
              future: _issueJsonListMap,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("get data");
                } else {
                  return const Text("data loading...");
                }
              }
            ),
            
            /*
            RadioListTile(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged
            ),
            */
            ElevatedButton(
              child: const Text("前の問題へ"),
              onPressed: _decrementIssueCounter
            ),
            ElevatedButton(
              child: const Text("次の問題へ"),
              onPressed: _incrementIssueCounter
            ),
          ],
        ),
      )
    );
  }
}
