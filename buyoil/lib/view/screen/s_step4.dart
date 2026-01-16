import 'dart:ui';

import 'package:buyoil/model/ui_state_usb_port.dart';
import 'package:buyoil/view/widget/w_step_nav.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../model/ui_state_step4.dart';
import '../../router.dart';
import '../../viewmodel/vm_step4.dart';
import '../widget/w_header.dart';

class Step4Screen extends ConsumerStatefulWidget {
  final double water, oil;

  const Step4Screen({super.key, required this.water, required this.oil});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => Step4ScreenState();
}

class Step4ScreenState extends ConsumerState<Step4Screen> {
  double water = 0.0;
  double oil = 0.0;

  @override
  void initState() {
    water = widget.water;
    oil = widget.oil;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { // 콜백이 실행될 때 위젯이 여전히 트리에 있는지 확인 (안전장치)
        ref.watch(serialPortVMProvider.notifier).initPortState();
      }
    });
  }

  @override
  void didUpdateWidget(covariant Step4Screen oldWidget) {
    if(widget.oil != oldWidget.oil || widget.water != oldWidget.water) {
      setState(() {
        oil = widget.oil;
        water = widget.water;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(step4Provider.notifier);
    final state = ref.watch(step4Provider);
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: _body(),
          )
        ],
      )
    );
  }

  void afterLayout() {
    ref.listenManual(step4Provider, (_, state) {
      if(state is UIStateStep4Checked) {
        context.goNamed(RouteGroup.Step1.name);
      }
      if(state is UIStateStep4Retry) {
        context.goNamed(RouteGroup.Step1.name);
      }
    });
  }

  Widget _body() {
    final stateSerial = ref.watch(serialPortVMProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StepNavWidget(currentStep: 4, totalSteps: 4),
        Expanded(
          child: stateSerial.when(
            init: (_,__,___,____,______) {
              return defaultBody();
            },
            connected: (_,__,___,____,______) {
              return defaultBody();
            },
            loading: (_,__,___,____,______) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // 1. 원본 위젯
                  defaultBody(),
                  // 2. 블러 효과를 적용할 위젯
                  ClipRect( // 블러 효과가 위젯 경계를 넘어가지 않도록 ClipRect로 감쌉니다.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 블러 강도 조절
                      child: Container(
                        // BackdropFilter는 자식 위젯이 있어야 렌더링됩니다.
                        // 투명한 컨테이너를 배치하여 블러 효과만 적용되도록 합니다.
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.PRIMARY.withAlpha(20),
                      ),
                    ),
                  ),
                  // 3. 중앙에 CircularProgressIndicator 추가
                  const CircularProgressIndicator(
                    color: AppColors.PRIMARY, // 원하는 색상으로 변경 가능
                  ),
                ],
              );
            },
            error: (_,__,___,____,_____,______) {
              return defaultBody();
            },)
        ),
      ],
    );
  }

  _checkButton() {
    return ElevatedButton(
      onPressed: () {
        ref.read(serialPortVMProvider.notifier).okay();
      },
      style: ElevatedButton.styleFrom(
        elevation: 2, // 약간의 그림자
        backgroundColor: AppColors.PRIMARY
      ),
      child: Container(
          width: 331, height: 91, alignment: Alignment.center,
          child: Image.asset("${AppStrings.assetPath}img_check.png", width: 60, height: 60, color: Colors.white,)
      )
    );
  }

  _retryButton() {
    return ElevatedButton(
      onPressed: () {
        ref.read(serialPortVMProvider.notifier).recheck();
      },
      style: ElevatedButton.styleFrom(
        elevation: 2, // 약간의 그림자
          backgroundColor: AppColors.FF848282
      ),
      child: Container(
        width: 331, height: 91, alignment: Alignment.center,
          child: Image.asset("${AppStrings.assetPath}img_redo.png", width: 60, height: 60, color: Colors.white,)
      )
    );
  }

  Widget defaultBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("UCO: ${oil}g", style: AppStyles.tsStep4,),
          Text("Water: ${water}g", style: AppStyles.tsStep4,),
          SizedBox(height: 146,),
          Container(
            height: 91,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _retryButton(),
                  SizedBox(width: 101,),
                  _checkButton(),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}