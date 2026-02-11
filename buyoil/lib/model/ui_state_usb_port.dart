import 'package:buyoil/common/app_commands.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:usb_serial/usb_serial.dart';

part 'ui_state_usb_port.freezed.dart';

@freezed
sealed class UIStateUsbPort with _$UIStateUsbPort {

  const factory UIStateUsbPort.init({
    @Default([]) List<UsbDevice> availablePorts,
    UsbDevice? connectedDevice,
    dynamic port,
    PORT_COMMANDS? lastCommand,
    @Default(0) int resetFailCount,
  }) = UIStateUsbPortInit;

  const factory UIStateUsbPort.connected({
    @Default([]) List<UsbDevice> availablePorts,
    required UsbDevice? connectedDevice,
    dynamic port,
    PORT_COMMANDS? lastCommand,
    @Default(0) int resetFailCount,
  }) = UIStateUsbPortConnected;

  const factory UIStateUsbPort.loading({
    @Default([]) List<UsbDevice> availablePorts,
    required UsbDevice? connectedDevice,
    dynamic port,
    PORT_COMMANDS? lastCommand,
    @Default(0) int resetFailCount,
  }) = UIStateUsbPortLoading;

  const factory UIStateUsbPort.error({
    @Default([]) List<UsbDevice> availablePorts,
    UsbDevice? connectedDevice,
    dynamic port,
    required String errorMsg,
    PORT_COMMANDS? lastCommand,
    @Default(0) int resetFailCount,
  }) = UIStateUsbPortError;

}