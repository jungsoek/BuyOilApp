import 'package:buyoil/common/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';

class SettingButton extends StatefulWidget {
  final bool state;
  final Function onTap;
  const SettingButton({super.key, required this.state, required this.onTap, });

  @override
  State<SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  bool state = false;

  @override
  void initState() {
    state = widget.state;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant SettingButton oldWidget) {
    if(oldWidget.state != widget.state) {
      setState(() {
        state = widget.state;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.FF007C5E,
            borderRadius: BorderRadius.circular(5)),
        height: 203,
        child: Center(
            child: Image.asset(
              state ? "${AppStrings.assetPath}img_stop.png" : "${AppStrings.assetPath}img_stop.png",
              width: 90, height: 90,)
        ),
      ),
    );
  }

}