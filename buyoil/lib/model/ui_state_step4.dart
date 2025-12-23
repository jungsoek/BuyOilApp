import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_step4.freezed.dart';

@freezed
sealed class UIStateStep4 with _$UIStateStep4 {

  const factory UIStateStep4.init() = UIStateStep4Init;
  const factory UIStateStep4.retry() = UIStateStep4Retry;
  const factory UIStateStep4.checked() = UIStateStep4Checked;
}