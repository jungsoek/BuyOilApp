import 'package:buyoil/model/ui_state_step1.dart';
import 'package:buyoil/model/ui_state_step2.dart';
import 'package:buyoil/view/widget/circular_prograss.dart';
import 'package:buyoil/view/widget/w_step_nav.dart';
import 'package:buyoil/viewmodel/vm_step1.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../router.dart';
import '../../viewmodel/vm_step2.dart';
import '../widget/w_header.dart';

class Step2Screen extends ConsumerStatefulWidget {
  const Step2Screen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => Step2ScreenState();
}

class Step2ScreenState extends ConsumerState<Step2Screen> {
  @override
  void initState() {
    super.initState();
    afterLayout();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(step2Provider.notifier);
    final state = ref.watch(step2Provider);
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: state.when(
              init: () {
                return _initBody();
              },
              completed: () {
                return Container();
              })
          )
        ],
      )
    );
  }

  Widget? _openButton(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(338 / 2),
      onTap: () {
        ref.watch(step2Provider.notifier).pressedOpen();
      },
      child: Container(
        width: 338,
        height: 338,
        decoration: BoxDecoration(image: DecorationImage(image: Image.asset("${AppStrings.assetPath}img_open_btn.png", width: 338, height: 338,).image)),
        child: Center(
          child: Text(AppStrings.openAction.tr(), style: AppStyles.tsOpenBtn,),
        ),
      )
    );
  }

  void afterLayout() {
    ref.listenManual(step2Provider, (_, state) {
      if(state is UIStateStep2Completed) {
        context.goNamed(RouteGroup.Step3.name);
      } else {
        print("State:: ${state.runtimeType}");
      }
    });
  }

  Widget _initBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StepNavWidget(currentStep: 2, totalSteps: 4),
        Expanded(
            child: Center(
              child: _openButton(context, ref),
            )
        )
      ],
    );
  }

  _openDoorBody() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: AppColors.EFFDF6,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110, height: 110,
            child: RotatingImageCircularProgressBar(
              progress: 50,
              imagePath: "${AppStrings.assetPath}img_circular.png",),
          ),
          SizedBox(height: 24 - 3,),
          Text(AppStrings.doorOpening.tr(), style: AppStyles.tsDoorOpeningText,),
          SizedBox(height: 3,),
        ],
      ),
    );
  }
}