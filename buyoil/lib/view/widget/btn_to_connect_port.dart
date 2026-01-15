import 'package:buyoil/config.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectPortButton extends ConsumerStatefulWidget {
  const ConnectPortButton({super.key});

  @override
  ConsumerState<ConnectPortButton> createState() => _ConnectPortButtonState();
}

class _ConnectPortButtonState extends ConsumerState<ConnectPortButton> {
  int _tapCount = 0;
  DateTime? _lastTapTime;
  final int _requiredTaps = 5;
  final Duration _timeLimit = const Duration(seconds: 10);
  final String _secretCode = "1111";

  void _handleTap() {
    print("_handleTap");
    final now = DateTime.now();

    if (_lastTapTime == null || now.difference(_lastTapTime!) > _timeLimit) {
      _tapCount = 1;
      print("Tap count reset. Current tap: $_tapCount");
    } else {
      _tapCount++;
      print("Tap count: $_tapCount");
    }

    _lastTapTime = now;

    if (_tapCount >= _requiredTaps) {
      _tapCount = 0; // 카운트 초기화
      _lastTapTime = null; // 시간 초기화
      // _showSecretDialog();
      connectPort();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: Config.instance.isDebugMode ?
      Container(
        alignment: Alignment.center,
        width: 300,
        height: 300,
        child: Center(
          child: Text("Connect Port Button[DebugMode]"),
        ),
        color: Colors.blue.withAlpha(40),
      ) : Container(
        alignment: Alignment.center,
        width: 300,
        height: 300,
      ),
    );
  }

  void connectPort() {
    // ref.watch(serialPortVMProvider.notifier).connectPort();
    ref.watch(serialPortVMProvider.notifier).connectPort(context: context);
  }
}