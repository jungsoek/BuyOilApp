
// RoundedLeftTriangleWidget 클래스는 그대로 유지
import 'package:flutter/material.dart';

class RoundedLeftTriangleWidget extends StatelessWidget {
  final double width;
  final double height;
  final double cornerDepth; // 왼쪽 둥근 부분의 x축 깊이
  final double cornerSpread; // 왼쪽 둥근 부분이 y축으로 퍼지는 정도 (높이의 절반 기준)
  final Color color;

  const RoundedLeftTriangleWidget({
    Key? key,
    required this.width,
    required this.height,
    this.cornerDepth = 10.0, // 기본 깊이
    this.cornerSpread = 8.0, // 기본 퍼짐 정도
    this.color = Colors.blue,
  })  : assert(cornerSpread * 2 <= height, "cornerSpread * 2 cannot exceed height"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _RoundedLeftTrianglePainter(
          color: color,
          cornerDepth: cornerDepth,
          cornerSpread: cornerSpread,
        ),
      ),
    );
  }
}


class _RoundedLeftTrianglePainter extends CustomPainter {
  final Color color;
  final double cornerDepth;  // x축 방향으로 얼마나 들어갈지
  final double cornerSpread; // y축 방향으로 얼마나 펼쳐질지 (중심에서부터의 거리)

  _RoundedLeftTrianglePainter({
    required this.color,
    required this.cornerDepth,
    required this.cornerSpread,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path();

    final double width = size.width;
    final double height = size.height;

    // 왼쪽 둥근 부분이 시작되고 끝나는 y 좌표
    final double arcTopY = height / 2 - cornerSpread;
    final double arcBottomY = height / 2 + cornerSpread;

    // 경로 그리기 시작: 오른쪽 상단 (뾰족)
    path.moveTo(width, 0);

    // 오른쪽 상단에서 오른쪽 하단으로 직선 (뾰족)
    path.lineTo(width, height);

    // 오른쪽 하단에서 왼쪽 둥근 부분의 하단 시작점으로 직선 (뾰족한 연결)
    path.lineTo(cornerDepth, arcBottomY); // x 좌표는 cornerDepth, y는 arcBottomY

    // 왼쪽 둥근 부분: quadratic Bezier 곡선 사용
    // 제어점은 (0, height / 2) - 즉, 가장 왼쪽 중앙점
    // 끝점은 (cornerDepth, arcTopY)
    path.quadraticBezierTo(
        0, height / 2, // 제어점 (x1, y1) - 가장 뾰족해야 할 지점
        cornerDepth, arcTopY  // 끝점 (x2, y2)
    );

    // 왼쪽 둥근 부분의 상단 끝점에서 시작점(오른쪽 상단)으로 직선을 그어 경로를 닫음
    path.lineTo(width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoundedLeftTrianglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.cornerDepth != cornerDepth ||
        oldDelegate.cornerSpread != cornerSpread;
  }
}
