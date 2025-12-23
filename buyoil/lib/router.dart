import 'package:buyoil/model/ui_state_usb_port.dart';
import 'package:buyoil/view/screen/s_driver.dart';
import 'package:buyoil/view/screen/s_opening_door.dart';
import 'package:buyoil/view/screen/s_setting.dart';
import 'package:buyoil/view/screen/s_splash.dart';
import 'package:buyoil/view/screen/s_step1.dart';
import 'package:buyoil/view/screen/s_step2.dart';
import 'package:buyoil/view/screen/s_step3.dart';
import 'package:buyoil/view/screen/s_step4.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

enum RouteGroup {
  Splash("/splash", "splash"),
  Driver("/driver", "driver"),
  Step1("/step1", "step1"),
  OpeningDoor("/openingDoor", "openingDoor"),
  Step2("/step2", "step2"),
  Step3("/step3", "step3"),
  Step4("/step4", "step4"),
  Setting("/setting", "setting");

  final String path;
  final String name;

  const RouteGroup(this.path, this.name);
}


@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: RouteGroup.Splash.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: RouteGroup.Splash.path,
        name: RouteGroup.Splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteGroup.Driver.path,
        name: RouteGroup.Driver.name,
        builder: (context, state) => const DriverScreen(),
      ),
      GoRoute(
        path: RouteGroup.OpeningDoor.path,
        name: RouteGroup.OpeningDoor.name,
        builder: (context, state) => const OpeningDoorScreen(),
      ),
      GoRoute(
        path: RouteGroup.Step1.path,
        name: RouteGroup.Step1.name,
        builder: (context, state) => const Step1Screen(),
      ),
      GoRoute(
        path: RouteGroup.Step2.path,
        name: RouteGroup.Step2.name,
        builder: (context, state) => const Step2Screen(),
      ),
      GoRoute(
        path: RouteGroup.Step3.path,
        name: RouteGroup.Step3.name,
        builder: (context, state) => const Step3Screen(),
      ),
      GoRoute(
        path: RouteGroup.Step4.path,
        name: RouteGroup.Step4.name,
        builder: (context, state) {
          double water = double.tryParse(state.uri.queryParameters["water"]??"") ?? 0.0;
          double oil = double.tryParse(state.uri.queryParameters["oil"]??"") ?? 0.0;
          return Step4Screen(water: water, oil: oil);
        },
      ),
      GoRoute(
        path: RouteGroup.Setting.path,
        name: RouteGroup.Setting.name,
        builder: (context, state) => const SettingScreen(),
      ),
    ]
  );
}