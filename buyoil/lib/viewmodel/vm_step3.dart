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
    ref.watch(serialPortVMProvider.notifier).close();
    // // todo ok 처리
    // state = UIStateStep3.closeDoor();
    //
    // Future.delayed(Duration(seconds: 2), () {
    //   state = UIStateStep3.completed();
    // });
  }
}