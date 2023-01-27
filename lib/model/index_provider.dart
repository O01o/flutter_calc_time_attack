import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final indexNotifierProvider = StateNotifierProvider.autoDispose<IndexNotifier, int>((ref) {
  return IndexNotifier(ref);
});

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier(ref): super(0);

  void increment(int length) {
    if (state >= length - 1) { state = 0; }
    else { state++; }
  }

  void decrement(int length) {
    if (state == 0) { state = length -1; }
    else { state--; }
  }
}