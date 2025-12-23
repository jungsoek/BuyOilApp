import 'package:buyoil/model/ui_state_step1.dart';
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
import '../widget/w_header.dart';

class OpeningDoorScreen extends ConsumerStatefulWidget {
  const OpeningDoorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => OpeningDoorScreenState();
}

class OpeningDoorScreenState extends ConsumerState<OpeningDoorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: _openDoorBody()
          )
        ],
      )
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