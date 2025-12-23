import 'package:buyoil/common/app_strings.dart';
import 'package:buyoil/common/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class StepNavWidget extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const StepNavWidget({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  createState() => StepNavWidgetState();
}

class StepNavWidgetState extends State<StepNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 27, top: 33, bottom: 33, right: 39),
      color: AppColors.FF007C5E,
      width: 202,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0, bottom: 0,
            child: SizedBox(
              width: 5,
              height: double.infinity,
              child: DottedLine(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                lineLength: double.infinity,
                lineThickness: 2.0,
                dashLength: 8.0,
                dashColor: AppColors.PRIMARY,
                // dashGradient: [Colors.red, Colors.blue],
                dashRadius: 2.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                // dashGapGradient: [Colors.red, Colors.blue],
                dashGapRadius: 0.0,
              ),
            ),
          ),
          Positioned(
            child: _body(context),
          )
        ],
      )
    );
  }

  Widget _buildCircularImageStep(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.PRIMARY,
          child: CircleAvatar(
            radius: 7.5,
            backgroundColor: widget.currentStep != index ? AppColors.PRIMARY: Colors.white,
          )
        ),
        Text("${AppStrings.step.tr()} $index", style: AppStyles.tsStepNavText),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildCircularImageStep(1),
        _buildCircularImageStep(2),
        _buildCircularImageStep(3),
        _buildCircularImageStep(4),
      ],
    );
  }
}