import 'package:buyoil/view/widget/btn_home.dart';
import 'package:buyoil/view/widget/btn_to_setting.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../config.dart';
import '../widget/btn_to_connect_port.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SplashState();
}

class SplashState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 1. 화면이 그려진 직후 자동 연결 시도
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoConnect();
    });
  }

  void _autoConnect() {
    final state = ref.read(serialPortVMProvider);

    // 연결된 기기가 없고, 주변에 연결 가능한 기기가 감지되었다면 실행
    if (state.connectedDevice == null) {
      ref.read(serialPortVMProvider.notifier).connectPort(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(serialPortVMProvider);

    double water = 0.123;
    double oil = 0.456;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 58,
              bottom: 208,
              left: 300,
              right: 300,
              child: Image.asset("${AppStrings.assetPath}img_splash.png"),
            ),
            Positioned(
              bottom: 72, //20은 터치 영역 고려
              left: 0,
              right: 0,
              child: Center(child: _startButton(context)),
            ),
            Positioned(right: 0, top: 0, child: _homeButton(context)),
            Positioned(left: 0, top: 0, child: _settingButton(context)),
            if (Config.instance.isDebugMode)
              Positioned(
                right: 120,
                top: 16,
                child: Row(
                  children: [
                    Text(
                      "device ${ref.watch(serialPortVMProvider).connectedDevice?.deviceId ?? "not connected"}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            Positioned(left: 0, bottom: 0, child: _connectPortButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: TextButton(
        onPressed: () {
          ref.read(serialPortVMProvider.notifier).start();
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>((
            Set<MaterialState> states,
          ) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.PRIMARY.withAlpha(80); // 터치(pressed) 상태일 때 색
            }
            return AppColors.PRIMARY; // 기본 색
          }),
          // 선택적으로 배경색도 바꿀 수 있음
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        child: Text(AppStrings.startButton.tr(), style: AppStyles.tsStart),
      ),
    );
  }

  Widget _settingButton(BuildContext context) {
    return ToSettingButton();
  }

  Widget _connectPortButton(BuildContext context) {
    return ConnectPortButton();
  }

  Widget _homeButton(BuildContext context) {
    return ToHomeBtn();
  }
}
