import 'package:buyoil/common/app_styles.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/app_colors.dart';

class SettingBox extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  const SettingBox({super.key, this.color = AppColors.PRIMARY, required this.text, this.height = 91});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5)),
      height: height,
      child: Center(
        child: Text(text, style: AppStyles.tsSettingBox, textAlign: TextAlign.center,),
      ),
    );
  }

}