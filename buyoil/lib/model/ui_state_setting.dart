import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state_setting.freezed.dart';

@freezed
sealed class UIStateSetting with _$UIStateSetting {

  const factory UIStateSetting.init({
    @Default(0) int oilContainer,
    @Default(0) double measureOil,
    @Default(0) double measureWater,
    @Default(false) bool isMotorOn,
    @Default(false) bool isValveOn,
  }) = UIStateSettingInit;
}