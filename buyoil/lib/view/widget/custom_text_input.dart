

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/app_colors.dart';
import '../../common/app_styles.dart';

class CustomTextInputField extends StatefulWidget {
  final String text;
  const CustomTextInputField({super.key, required this.text});

  @override
  createState() => TextInputFieldState();
}

class TextInputFieldState extends State<CustomTextInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTextInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      controller.text = widget.text;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 70, // TextField의 높이는 InputDecoration의 contentPadding으로 주로 조절
      child: TextField(
        controller: controller,
        style: AppStyles.tsTextField,
        cursorColor: AppColors.PRIMARY,
        enabled: false,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
          LengthLimitingTextInputFormatter(11),   // 최대 11자리까지 입력 제한
        ],
        decoration: InputDecoration(
          hintText: '',
          hintStyle: AppStyles.tsTextField,// 선택 사항: 안내 문구
          // contentPadding: EdgeInsets.symmetric(vertical: (70 - (/* 기본 폰트 높이 등 고려 */ 20))/2, horizontal: 15),
          // 높이를 정확히 70으로 맞추기 위해 contentPadding 조절이 필요할 수 있습니다.
          // TextField의 내부 텍스트 및 아이콘 크기에 따라 패딩을 조절해야 합니다.
          // 일반적으로 TextField의 높이는 내부 컨텐츠와 패딩에 의해 결정됩니다.
          // SizedBox로 높이를 강제하되, 내부 컨텐츠가 잘 보이도록 패딩을 주는 것이 좋습니다.
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0), // 패딩을 조절하여 내부 텍스트가 중앙에 오도록

          // 테두리 설정
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
          // 포커스 됐을 때 테두리 설정 (선택 사항)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
          // 활성화되어 있지만 포커스되지 않았을 때 테두리 (선택 사항, border와 동일하게 할 수도 있음)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
          // 비활성화 됐을 때 테두리 (선택 사항)
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
          // 오류 발생 시 테두리 (선택 사항)
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: AppColors.PRIMARY, width: 1.0), // 기본 테두리
          ),
        ),
        // 기타 TextField 속성들
        keyboardType: TextInputType.text,
        // obscureText: true, // Input Password 시
        // controller: _textController, // TextEditingController 연결
        // onChanged: (text) {
        //   print("Current text: $text");
        // },
        // onSubmitted: (text) {
        //   print("Submitted text: $text");
        // },
      ),
    );
  }
}