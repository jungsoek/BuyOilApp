import 'package:buyoil/view/widget/w_step_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../model/ui_state_step3.dart';
import '../../router.dart';
import '../../viewmodel/vm_step3.dart';
import '../widget/w_header.dart';

class Step3Screen extends ConsumerStatefulWidget {
  const Step3Screen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => Step3ScreenState();
}

class Step3ScreenState extends ConsumerState<Step3Screen> {
  @override
  void initState() {
    super.initState();
    afterLayout();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(step3Provider.notifier);
    final state = ref.watch(step3Provider);
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: state.when(
              init: () {
                return _initBody();
              },
              closeDoor: () {
                return _closeDoorBody();
              },
              completed: () {
                return Container();
              })
          )
        ],
      )
    );
  }

  Widget? _closeButton(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(338 / 2),
      onTap: () {
        ref.watch(step3Provider.notifier).pressedClose();
      },
      child: Container(
        width: 338,
        height: 338,
        decoration: BoxDecoration(image: DecorationImage(image: Image.asset("${AppStrings.assetPath}img_close_btn.png", width: 338, height: 338,).image)),
        child: Center(
          child: Text(AppStrings.closeAction.tr(), style: AppStyles.tsOpenBtn,),
        ),
      )
    );
  }

  void afterLayout() {
    // ref.listenManual(step3Provider, (_, state) {
    //   if(state is UIStateStep3Completed) {
    //     context.goNamed(RouteGroup.Step4.name);
    //   }
    // });
  }

  Widget _initBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StepNavWidget(currentStep: 3, totalSteps: 4),
        Expanded(
            child: Center(
              child: _closeButton(context, ref),
            )
        )
      ],
    );
  }

  _closeDoorBody() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: AppColors.EFFDF6,
    );
  }
}