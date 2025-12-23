import 'package:buyoil/model/ui_state_step4.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm_step4.g.dart';

@riverpod
class Step4 extends _$Step4 {
  @override
  UIStateStep4 build() {
    return UIStateStep4.init();
  }

  void pressedRetry() {
    state = UIStateStep4.retry();
  }

  void pressedChecked() {
    state = UIStateStep4.checked();
  }
}