import 'package:freezed_annotation/freezed_annotation.dart';

part 'toast_state.freezed.dart';
part 'toast_state.g.dart';

@freezed
abstract class ToastState with _$ToastState {
  const factory ToastState({
    @Default(false) bool isVisible,
    String? message,
  }) = _ToastState;

  factory ToastState.fromJson(Map<String, Object?> json) => _$ToastStateFromJson(json);
}