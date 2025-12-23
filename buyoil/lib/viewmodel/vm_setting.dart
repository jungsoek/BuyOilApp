import 'package:buyoil/model/ui_state_setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vm_setting.g.dart';

@riverpod
class Setting extends _$Setting {
  @override
  UIStateSetting build() {
    return UIStateSetting.init();
  }

  void toggleMotor() {
    state = state.copyWith(isMotorOn: !state.isMotorOn);
  }

  void toggleValve() {
    state = state.copyWith(isValveOn: !state.isValveOn);
  }
}