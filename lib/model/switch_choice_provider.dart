import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calc_time_attack/utils/switch_choice.dart';

final switchChoiceProvider = StateNotifierProvider<SwitchChoiceNotifier, SwitchChoice>((ref) {
  return SwitchChoiceNotifier(ref);
});

class SwitchChoiceNotifier extends StateNotifier<SwitchChoice> {
  SwitchChoiceNotifier(ref): super(SwitchChoice.none);

  void switching(int yourAnswerIndex) {
      if (yourAnswerIndex == 0) { state = SwitchChoice.a; }
      else if (yourAnswerIndex == 1) { state = SwitchChoice.b; }
      else if (yourAnswerIndex == 2) { state = SwitchChoice.c; }
      else if (yourAnswerIndex == 3) { state = SwitchChoice.d; }
      else { state = SwitchChoice.none; }
  }
}