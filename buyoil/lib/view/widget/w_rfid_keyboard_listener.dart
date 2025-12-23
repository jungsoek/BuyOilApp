import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RfidKeyboardListener extends StatefulWidget {
  final void Function(String uid) onDetected;

  const RfidKeyboardListener({Key? key, required this.onDetected}) : super(key: key);

  @override
  _RfidKeyboardListenerState createState() => _RfidKeyboardListenerState();
}

class _RfidKeyboardListenerState extends State<RfidKeyboardListener> {
  String _inputBuffer = "";

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(), // 포커스 강제
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          final key = event.data.logicalKey.keyLabel;

          if (key == '\n' || key == 'Enter') {
            // 엔터 입력 시 UID 완성
            if (_inputBuffer.isNotEmpty) {
              widget.onDetected(_inputBuffer);
              _inputBuffer = "";
            }

          } else if (key.isNotEmpty) {
            _inputBuffer += key;
          }
        }
      },
      child: SizedBox.shrink(), // UI는 필요 없음
    );
  }
}
