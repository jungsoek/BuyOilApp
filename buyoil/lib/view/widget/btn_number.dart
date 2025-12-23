import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const NumberButton({
    Key? key,
    required this.number,
    required this.onPressed,
    this.width = 100.0,
    this.height = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50], // 버튼 배경색 (선택 사항)
        borderRadius: BorderRadius.circular(12.0), // 버튼 모서리 둥글기 (선택 사항)
        boxShadow: [ // 살짝 그림자 효과 (선택 사항)
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material( // InkWell 효과를 위해 Material 위젯으로 감싸기
        color: Colors.transparent, // Material의 색상은 투명하게 하여 Container 색상이 보이도록
        borderRadius: BorderRadius.circular(12.0), // InkWell 효과가 Container 모양을 따르도록
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0), // 튀어나가지 않도록 동일한 borderRadius 적용
          onTap: onPressed,
          splashColor: Colors.blueAccent.withOpacity(0.3), // 눌렀을 때 퍼지는 효과 색상
          highlightColor: Colors.blueAccent.withOpacity(0.1), // 누르고 있을 때 배경 하이라이트 색상
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}