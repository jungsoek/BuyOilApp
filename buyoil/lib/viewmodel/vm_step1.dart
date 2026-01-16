import 'package:buyoil/common/utils/show_toast.dart';
import 'package:buyoil/viewmodel/vm_sendUser.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/ui_state_step1.dart';

part 'vm_step1.g.dart';

@riverpod
class Step1 extends _$Step1 {
  @override
  UIStateStep1 build() {
    final controller = TextEditingController();

    controller.addListener(() {
      state = state.copyWith(phoneNumber: controller.text);
    });

    return UIStateStep1.input(phoneNumber: "", controller: controller);
  }

  void rfidAuthenticated(String uid) {
    // 화면 입력 필드에는 절대 반영하지 않음
    state = state.copyWith(rfidNumber: uid);

    if (uid.length == 10) {
      ref.read(serialPortVMProvider.notifier).sendRFIDNumber(uid);
    }

    return;
  }


  /// 숫자 버튼 처리
  void pressedNumber(String buttonText) {
    if (buttonText == '<') {
      if (state.phoneNumber.isNotEmpty) {
        final updated = state.phoneNumber.substring(
          0,
          state.phoneNumber.length - 1,
        );

        state = state.copyWith(phoneNumber: updated);
      }
      return;
    }

    if (buttonText == 'V') {
      // 전화번호 전송 (기존 메서드 유지)
      ref.read(serialPortVMProvider.notifier).sendPhoneNumber(state.phoneNumber);
      return;
    }

    if (state.phoneNumber.length < 11) {
      state = state.copyWith(phoneNumber: state.phoneNumber + buttonText);
    }
  }

  /// 오류 토스트 표시
  void showErrorToast({int seconds = 2}) {
    state = state.copyWith(showErrorToast: true);

    Future.delayed(Duration(seconds: seconds), () {
      if (state.showErrorToast) {
        state = state.copyWith(showErrorToast: false);
      }
    });
  }
}


