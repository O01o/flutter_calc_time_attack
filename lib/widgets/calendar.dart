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
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TableCalendar(
        focusedDay: now,
        firstDay: DateTime.utc(now.year-50, 1, 1),
        lastDay: DateTime.utc(now.year+50, 12, 31),
        
      )
    );
  }
}
