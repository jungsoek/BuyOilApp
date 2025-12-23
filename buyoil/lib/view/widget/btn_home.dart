import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_strings.dart';
import '../../router.dart';

class ToHomeBtn extends ConsumerWidget {
  const ToHomeBtn({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.watch(serialPortVMProvider.notifier).goToSplash().whenComplete(() {
          context.goNamed(RouteGroup.Splash.name);
        });
      },
      child: Container(
        width: 99,
        height: 49,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
        child: Image.asset("${AppStrings.assetPath}img_home.png"),
      ),
    );
  }

}