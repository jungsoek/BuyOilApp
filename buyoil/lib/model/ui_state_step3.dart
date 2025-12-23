import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_step3.freezed.dart';

@freezed
sealed class UIStateStep3 with _$UIStateStep3 {

  const factory UIStateStep3.init() = UIStateStep3Init;
  const factory UIStateStep3.closeDoor() = UIStateStep3CloseDoor;
  const factory UIStateStep3.completed() = UIStateStep3Completed;
}