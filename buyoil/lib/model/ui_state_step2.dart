import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_step2.freezed.dart';

@freezed
sealed class UIStateStep2 with _$UIStateStep2 {

  const factory UIStateStep2.init() = UIStateStep2Init;
  const factory UIStateStep2.completed() = UIStateStep2Completed;
}