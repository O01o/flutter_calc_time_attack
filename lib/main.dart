import 'package:flutter/material.dart';
import 'package:flutter_calc_time_attack/widgets/calc_time_attack.dart';
import 'package:flutter_calc_time_attack/widgets/score.dart';
import 'package:flutter_calc_time_attack/widgets/home.dart';
import 'package:flutter_calc_time_attack/widgets/calendar.dart';

import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(title: 'Home Screen'),
        "/calc_time_attack":(context) => CalcTimeAttackScreen(title: 'Calc Time Attack Screen'),
        "/score":(context) => ScoreScreen(title: 'Score Screen'),
        "/calendar":(context) => CalendarScreen(title: 'Calendar Screen'),
      }
    );
  }
}