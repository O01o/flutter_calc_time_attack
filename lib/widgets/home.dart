import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_calc_time_attack/model/issue_data.dart';

import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("aiueo"),
            ElevatedButton(
              child: const Text("問題を解く"),
              onPressed: () {
                Navigator.pushNamed(context, './calc_time_attack');
              },
            ),
            ElevatedButton(
              child: const Text("日々の成果を確認する"),
              onPressed: () {
                Navigator.pushNamed(context, './calendar');
              },
            ),
            ElevatedButton(
              child: const Text("アプリを閉じる"),
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
                      onPressed: () => exit(0),
                    ),
                  ],
                )
              )
            )
          ],
        )
      )
    );
  }
}
