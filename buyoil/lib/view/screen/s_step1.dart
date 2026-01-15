import 'package:buyoil/model/ui_state_step1.dart';
import 'package:buyoil/view/widget/w_left_triangle.dart';
import 'package:buyoil/view/widget/w_rfid_keyboard_listener.dart';
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
import '../widget/custom_text_input.dart';
import '../widget/step1/buttons_number.dart';
import '../widget/w_header.dart';

// ==========================
// Step1 Screen
// ==========================
class Step1Screen extends ConsumerStatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  ConsumerState<Step1Screen> createState() => Step1ScreenState();
}

class Step1ScreenState extends ConsumerState<Step1Screen> {

  void _onRfidDetected(String uid) {
    print('[RFID UID by _onRfidDetected]: $uid');
    print('RAW UID: "$uid"');
    print('Length: ${uid.length}');
    for (final c in uid.codeUnits) {
      print('0x${c.toRadixString(16)}');
    }

    if (uid.length == 10) {
      ref.read(step1Provider.notifier).rfidAuthenticated(uid);
    }
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(step1Provider);

    return Scaffold(
      body: Stack(
        children: [
          RfidKeyboardListener(onDetected: _onRfidDetected),
          Column(
            children: [
              HeaderWidget(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StepNavWidget(currentStep: 1, totalSteps: 4),
                    Expanded(child: Stack(children: [_body(context, state)])),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }

  Widget _body(BuildContext context, UIStateStep1 state) {
    return Row(
      children: [
        Expanded(
          flex: 512,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.enterPhoneNumber.tr(),
                  style: AppStyles.enterPhoneNumberTextStyle,
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 10),
                CustomTextInputField(text: state.phoneNumber),
                const SizedBox(height: 10),
                Text('Please tap your card on the RFID reader for authentication.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        RoundedLeftTriangleWidget(
          width: 36,
          height: 68,
          color: AppColors.D6E7DF,
        ),
        Expanded(
          flex: 625,
          child: Container(
            color: AppColors.D6E7DF,
            child: Center(
              child: NumberButtonGroup(
                onButtonPressed: (text) {
                  ref.read(step1Provider.notifier).pressedNumber(text);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
