import 'package:buyoil/common/app_commands.dart';
import 'package:buyoil/viewmodel/vm_serial_port.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugButtons extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DebugBtnState();

}

class DebugBtnState extends ConsumerState<DebugButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // height: 120,
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        alignment: WrapAlignment.start,
          children: [
            _btn(PORT_RESPONSES.ok),
            _btnDivided("[ANS"),
            _btnDivided("]OK#"),
            _btn(PORT_RESPONSES.open),
            _btn(PORT_RESPONSES.fail),
            _btn(PORT_RESPONSES.notAuth),
            _btn(PORT_RESPONSES.reject),
            _btn(PORT_RESPONSES.ok),
            _btn(PORT_RESPONSES.full),
            _btnString("[ANS]O5.55W6.56E#"),
            _btn(PORT_RESPONSES.driverTrue),
            _btn(PORT_RESPONSES.driverFalse),
            _btnString("[CMD]SLEEP#", toMCU:true),
            _btn(PORT_RESPONSES.stmSleep),
            _btnPhone(),
          ],
      ),
    );
  }

  _btn(PORT_RESPONSES res) {
    return TextButton(onPressed: () {
      ref.watch(serialPortVMProvider.notifier).listenDebug("${res.response}#");

    },child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Text(res.response+"#"))
    );
  }

  _btnDivided(String text) {
    return TextButton(onPressed: () {
      ref.watch(serialPortVMProvider.notifier).listenDebug(text);

    },child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Text(text))
    );
  }
  _btnString(String msg, {bool toMCU = false}) {
    return TextButton(onPressed: () {
      ref.watch(serialPortVMProvider.notifier).writeDebug(msg);
    },
      child: Container(
      padding: EdgeInsets.all(10),
      color: toMCU ? Colors.yellow: Colors.white,
      child: Text(msg),
    ),
    );
  }

  _btnPhone() {
    return TextButton(onPressed: () {
      ref.watch(serialPortVMProvider.notifier).sendPhoneNumber("000000");
    }, child: Container(
      padding: EdgeInsets.all(10),
      color: Colors.yellowAccent,
      child: Text("[V]   000000 phone V click"),
    ));
  }

}