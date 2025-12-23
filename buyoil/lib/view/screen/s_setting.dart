import 'package:buyoil/common/app_strings.dart';
import 'package:buyoil/view/widget/setting/box_setting.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/app_colors.dart';
import '../../common/app_styles.dart';
import '../../viewmodel/vm_setting.dart';
import '../widget/setting/btn_setting.dart';
import '../widget/w_header.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends ConsumerState<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(settingProvider.notifier);
    final state = ref.watch(settingProvider);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            HeaderWidget(),
            Expanded(
              child: Column(
                children: [
                  Spacer(flex: 49),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(AppColors.PRIMARY),
                            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
                        ),
                        child: Container(
                          height: 91,
                          // padding: EdgeInsets.all(20),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppStrings.assetPath + "img_gear.png", width: 52.5, height: 52.5,),
                              SizedBox(width: 13.5,),
                              Text(AppStrings.settingsMenu.tr(), style: AppStyles.tsSetting,)
                            ],
                          ),
                        )
                    ),
                  ),
                  Spacer(flex: 163),
                  Container(
                    height: 203 + 31 + 91,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40,),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SettingBox(color: AppColors.FF868686, text: AppStrings.oilContainerLabel.tr()),
                                SizedBox(height: 31,),
                                SettingBox(text: "${state.oilContainer}kg", height: 203),
                              ],
                            )
                        ),
                        SizedBox(width: 28,),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SettingBox(color: AppColors.FF868686, text: AppStrings.oilContainerLabel.tr()),
                                SizedBox(height: 31,),
                                SettingBox(text: "Oil:${state.measureOil}g\nWater: ${state.measureWater}g", height: 203),
                              ],
                            )
                        ),
                        SizedBox(width: 28,),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SettingBox(color: AppColors.FF868686, text: AppStrings.oilContainerLabel.tr()),
                                SizedBox(height: 31,),
                                SettingButton(
                                  state: state.isMotorOn,
                                  onTap: () {
                                    notifier.toggleMotor();
                                  },
                                ),
                              ],
                            )
                        ),
                        SizedBox(width: 28,),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SettingBox(color: AppColors.FF868686, text: AppStrings.oilContainerLabel.tr()),
                                SizedBox(height: 31,),
                                SettingButton(
                                    state: state.isValveOn,
                                    onTap: () {
                                      notifier.toggleValve();
                                    },
                                ),
                              ],
                            )
                        ),
                        SizedBox(width: 40,),
                      ],
                    ),
                  ),
                  Spacer(flex: 93),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void afterLayout() {
    // ref.listenManual(SettingProvider, (_, state) {
    //   if(state is UIStateSettingCompleted) {
    //     context.goNamed(RouteGroup.Setting.name);
    //   }
    // });
  }
}