import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_strings.dart';

// 공통 버튼 위젯 (이전에 만들었던 NumberButton 기반으로 수정)
class CalculatorButton extends StatelessWidget {
  final String text; // 숫자 또는 특수 문자
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color splashColor;
  final TextStyle textStyle;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 100.0,
    this.height = 100.0,
    this.backgroundColor = Colors.white, // 기본 배경색
    this.splashColor = Colors.black12,   // 기본 스플래시 색상 (살짝 효과)
    this.textStyle = const TextStyle(
      fontSize: 28, // 기본 폰트 크기 조정
      fontWeight: FontWeight.normal, // 기본 폰트 굵기 조정
      color: Colors.black87,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0), // 모서리 둥글기
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(20),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPressed,
          splashColor: splashColor,
          highlightColor: splashColor.withAlpha(50),
          child: Center(
            child: text.isSpecial() ? Image.asset(AppStrings.assetPath + (text == '<' ? 'img_back.png' : 'img_check.png'), width: 55, height: 55,) :
            Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}

extension on String {
  bool isSpecial() {
    if(this == '<' || this == 'V') {
      return true;
    }
    return false;
  }
}


// 숫자 및 특수 문자 버튼 그룹 위젯
class NumberButtonGroup extends StatelessWidget {
  // 각 버튼 클릭 시 호출될 콜백 함수 (String: 눌린 버튼의 텍스트)
  final Function(String) onButtonPressed;

  const NumberButtonGroup({
    Key? key,
    required this.onButtonPressed,
  }) : super(key: key);

  // 버튼 레이아웃 정의
  static const List<List<String>> _buttonLayout = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['<', '0', 'V'], // '<'는 백스페이스, 'V'는 확인/입력 등으로 사용 가능
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 내용만큼만 크기 차지
      children: _buttonLayout.map((rowItems) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0), // 행 간 간격
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 버튼들을 행 중앙에 배치
            children: rowItems.map((item) {
              // 버튼 스타일 커스터마이징 (선택 사항)
              Color buttonBgColor = AppColors.BG_NUMBER;
              TextStyle buttonTextStyle = TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: AppColors.TEXT_20,
              );
              Color buttonSplashColor = Colors.blueGrey.withAlpha(20);

              if (item == '<') { // 특수 문자 버튼 스타일
                buttonBgColor = AppColors.FF868686;
              } else if (item == 'V') {
                buttonBgColor = AppColors.PRIMARY;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0), // 버튼 간 간격
                child: CalculatorButton(
                  text: item,
                  onPressed: () => onButtonPressed(item),
                  backgroundColor: buttonBgColor,
                  splashColor: buttonSplashColor,
                  textStyle: buttonTextStyle,
                  // width: 90, // 버튼 크기 조절 필요시
                  // height: 90,
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}