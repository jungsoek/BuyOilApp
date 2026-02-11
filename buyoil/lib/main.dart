import 'package:buyoil/router.dart';
import 'package:buyoil/view/widget/debug_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'common/utils/toast/custom_toast.dart';
import 'config.dart';

Future<void> main() async {
  Config(isDebugMode: true);

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ko'),
          Locale('vi'),
          Locale('ja'),
        ],
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        path: 'assets/translations',
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // 배경색 투명
        statusBarIconBrightness: Brightness.dark,
        // 아이콘 어둡게 (흰색 배경 위에서 보이도록)
        statusBarBrightness: Brightness.light,

        // 내비게이션 바 (하단 - Android)
        systemNavigationBarColor: Colors.transparent,
        // 배경색 투명
        systemNavigationBarDividerColor: Colors.transparent,
        // 구분선 투명 (선택 사항)
        systemNavigationBarIconBrightness: Brightness.dark, // 아이콘 어둡게
      ),
      child: DefaultTextHeightBehavior(
        textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
          leadingDistribution: TextLeadingDistribution.proportional,
        ),
        child: MaterialApp.router(
          // 간단하게 성능 확인 하고 싶을 때 turn on
          // showPerformanceOverlay: true,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'BuyOil',
          routerConfig: ref.watch(routerProvider),
          builder: (context, child) {
            // ✅ 1. child를 Scaffold로 감싸서 FloatingActionButton을 사용할 수 있는 구조로 만듭니다.
            final appWithScaffold = Scaffold(
              // Scaffold 자체의 배경은 투명하게 하여 기존 앱 화면이 그대로 보이도록 합니다.
              backgroundColor: Colors.transparent,
              // 기존 앱 화면(router가 빌드한 페이지)을 body로 설정합니다.
              body: child,
              // ✅ 2. 디버그 모드일 때만 FloatingActionButton을 표시합니다.
              floatingActionButton: Config.instance.isDebugMode
                  ? FloatingActionButton(
                      // 버튼을 눌렀을 때 DebugButtons 위젯을 포함하는 다이얼로그를 띄웁니다.
                      onPressed: () {
                        // 현재 다이얼로그가 표시되어 있으면 닫고, 아니면 연다.
                        if (isDialogShown) {
                          Navigator.of(rootNavigatorKey.currentContext!).pop();
                          // 상태를 false로 업데이트
                          setState(() {
                            isDialogShown = false;
                          });
                        } else {
                          // 상태를 true로 먼저 업데이트
                          setState(() {
                            isDialogShown = true;
                          });
                          showDialog(
                            context: rootNavigatorKey.currentContext!,
                            barrierColor: Colors.transparent,
                            builder: (BuildContext dialogContext) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 100),
                                    child: DebugButtons(),
                                  ),
                                ],
                              );
                            },
                          ).then((_) {
                            // 사용자가 다이얼로그 외부를 탭하여 닫는 경우에도 상태를 업데이트
                            setState(() {
                              isDialogShown = false;
                            });
                          });
                        }
                      },
                      // 버튼 아이콘과 배경색 설정
                      backgroundColor: Colors.blueAccent.withOpacity(0.5),
                      child: Icon(
                        isDialogShown ? Icons.close : Icons.bug_report,
                        color: Colors.white,
                      ),
                    )
                  : null, // 디버그 모드가 아니면 FAB를 표시하지 않습니다.
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startTop, // FAB 위치를 우측 상단으로 설정
            );

            // ✅ 3. 기존의 CustomToast를 표시하기 위한 Overlay 구조는 그대로 유지합니다.
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (overlayContext) {
                    return Stack(
                      children: [
                        // Scaffold로 감싸진 앱을 여기에 배치합니다.
                        Positioned.fill(child: appWithScaffold),
                        const CustomToast(),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
