import 'package:buyoil/common/app_strings.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../config.dart';
import 'btn_home.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      color: AppColors.F5F5F5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 106,
            margin: EdgeInsets.only(left: 22),
            child: Image.asset("${AppStrings.assetPath}img_logo.png"),
          ),
          Expanded(child: SizedBox.shrink()),
          ToHomeBtn()
        ],
      ),
    );
  }
}