import 'package:flutter/material.dart';
import 'package:flutter_calc_time_attack/widgets/calc_time_attack.dart';
import 'package:flutter_calc_time_attack/widgets/score.dart';
import 'package:flutter_calc_time_attack/widgets/home.dart';
import 'package:flutter_calc_time_attack/widgets/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(title: 'Home Screen'),
        "/calc_time_attack":(context) => const CalcTimeAttackScreen(title: 'Calc Time Attack Screen'),
        "/score":(context) => const ScoreScreen(title: 'Score Screen'),
        "/calendar":(context) => const ScoreScreen(title: 'Calendar Screen'),
      }
    );
  }
}