import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'toast_state.dart'; // ToastState 임포트

part 'toast_provider.g.dart'; // 생성될 파일, `flutter pub run build_runner build` 실행 필요

@riverpod
class Toast extends _$Toast { // 클래스 이름은 원하는 대로 (예: Toast, GlobalToast 등)
  // _$ 접두사가 붙은 생성된 클래스를 상속
  Timer? _timer; // 타이머를 Notifier 내에서 관리

  @override
  ToastState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const ToastState();
  }

  void showToast(String message, {Duration duration = const Duration(seconds: 2)}) {
    _timer?.cancel(); // 이전 타이머가 있다면 취소

    state = state.copyWith(message: message, isVisible: true);

    _timer = Timer(duration, () {
      // 현재 상태의 메시지와 비교하여 의도치 않은 hide 방지
      if (state.message == message && state.isVisible) {
        hideToast();
      }
    });
  }

  void hideToast() {
    state = state.copyWith(isVisible: false, message: null);
    _timer?.cancel(); // hide가 명시적으로 호출될 때도 타이머 취소
    _timer = null;
  }

}