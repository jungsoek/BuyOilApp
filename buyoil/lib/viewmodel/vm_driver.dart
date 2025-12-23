import 'package:buyoil/model/ui_state_step3.dart';
import 'package:buyoil/router.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm_driver.g.dart';

@riverpod
class Driver extends _$Driver {
  @override
  UIStateStep3 build() {
    return UIStateStep3.init();
  }

  // [CMD]CLOSES# -> 첫페이지로 TODO 응답 받을게 있으면 처리
  void pressedClose() {
    ref.watch(serialPortVMProvider.notifier).close().whenComplete(() {
      ref.read(routerProvider).goNamed(RouteGroup.Splash.name);
    });
    // // todo ok 처리
    // state = UIStateStep3.closeDoor();
    //
    // Future.delayed(Duration(seconds: 2), () {
    //   state = UIStateStep3.completed();
    // });
  }
}