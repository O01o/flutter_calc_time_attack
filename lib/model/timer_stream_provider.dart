import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final timerStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  int time = 0;

  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    time++;
    yield time;
  }
});