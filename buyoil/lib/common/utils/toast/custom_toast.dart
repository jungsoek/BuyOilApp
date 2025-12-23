import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_colors.dart';
import '../../app_styles.dart';
import 'toast_provider.dart';

class CustomToast extends ConsumerWidget {
  const CustomToast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toastState = ref.watch(toastProvider);

    if (!toastState.isVisible || toastState.message == null) {
      return const SizedBox.shrink(); // 보이지 않을 때는 빈 위젯
    }

    return Positioned(
      top: 57,
      left: 0,
      right: 0,
      child: IgnorePointer( // 토스트 뒤의 UI 터치 가능하도록
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: BoxBorder.all(color: AppColors.D32F2F, width: 1),
                  color: Color(0xfffde3e3)),
              child: Text( toastState.message ?? "",
                  textAlign: TextAlign.center,
                  style: AppStyles.tsStep1Toast),
            ),
          )

          // child: Container(
          //   width: double.maxFinite,
          //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //   decoration: BoxDecoration(
          //       color: const Color(0xFFFFFFFF),
          //       borderRadius: BorderRadius.circular(6.0),
          //       border: Border.all(color: AppColors.TEXT_20, width: 1)
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Flexible(
          //         child: Text(
          //           toastState.message ?? "",
          //           style: Theme.of(context).textTheme.displayLarge,
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        )
      ),
    );
  }
}