import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/ui_state_step2.dart';

part 'vm_step2.g.dart';

@riverpod
class Step2 extends _$Step2 {
  @override
  UIStateStep2 build() {
    return UIStateStep2.init();
  }

  pressedOpen() async {
    ref.watch(serialPortVMProvider.notifier).open();
  }
}