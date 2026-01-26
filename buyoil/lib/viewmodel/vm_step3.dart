import 'package:buyoil/model/ui_state_step3.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm_step3.g.dart';

@riverpod
class Step3 extends _$Step3 {
  @override
  UIStateStep3 build() {
    return UIStateStep3.init();
  }

  void pressedClose() {
    // 1. 상태를 로딩으로 변경 (UI에서 스피너가 돌게 됨)
    state = const UIStateStep3.loading();

    // 2. 실제 시리얼 포트에 CLOSE 명령 전송
    ref.read(serialPortVMProvider.notifier).close();
  }
}