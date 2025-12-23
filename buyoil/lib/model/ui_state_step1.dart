import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_step1.freezed.dart';

@freezed
sealed class UIStateStep1 with _$UIStateStep1 {
  const factory UIStateStep1.input({
    @Default("") String phoneNumber,
    @Default("") String rfidNumber,
    required TextEditingController controller,
    @Default(false) bool showErrorToast,
  }) = UIStateStep1Input;

  const factory UIStateStep1.completed({
    @Default("") String phoneNumber,
    @Default("") String rfidNumber,
    required TextEditingController controller,
    @Default(false) bool showErrorToast,
  }) = UIStateStep1Completed;
}
