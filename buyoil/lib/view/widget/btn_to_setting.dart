import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config.dart';
import '../../router.dart';

class ToSettingButton extends StatefulWidget {
  const ToSettingButton({super.key});

  @override
  State<ToSettingButton> createState() => _ToSettingButtonState();
}

class _ToSettingButtonState extends State<ToSettingButton> {
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
      print("Required taps met. Showing dialog.");
      _showSecretDialog();
    }
  }

  Future<void> _showSecretDialog() async {
    final TextEditingController controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false, // 다이얼로그 바깥을 탭해도 닫히지 않도록
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Password'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            obscureText: true, // 비밀번호처럼 보이도록 (선택 사항)
            decoration: const InputDecoration(hintText: '4 Digits'),
            maxLength: 4,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(controller.text); // 입력된 값 반환하며 닫기
              },
            ),
          ],
        );
      },
    );

    if (result == _secretCode) {
      print("Secret code matched. Navigating to SecretPage.");
      if (mounted) { // 위젯이 여전히 마운트되어 있는지 확인
        context.pushNamed(RouteGroup.Setting.name);
      }
    } else if (result != null) {
      print("Secret code does not match. Entered: $result");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
        );
      }
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
        child: Text("Move To Setting Page Button[DebugMode]"),
      ),
      color: Colors.red.withAlpha(40),
    ) : Container(
      alignment: Alignment.center,
      width: 300,
      height: 300,
      )
    );
  }
}