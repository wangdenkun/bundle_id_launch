import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bundle_id_launch/bundle_id_launch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await BundleIdLaunch.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _launch() async{
    var bundleId = _textEditingController.text;
    if (bundleId.isEmpty) return;
    var res = await BundleIdLaunch.launch(bundleId: bundleId);
    debugPrint('---> _MyAppState._launch res: ${res}');
  }
  Future<void> _openSystemSetting() async{
    await BundleIdLaunch.openSystemSetting();
  }

  @override
  Widget build(BuildContext context) {
    // _textEditingController.text = 'com.alibaba.android.rimet';
    // _textEditingController.text = 'com.choicewell.switcher_mobile';
    // _textEditingController.text = 'com.tencent.wemeet.controller';
    _textEditingController.text = 'com.systec.umeeting.zrc';
    // _textEditingController.text = 'us.zoom.zrc';
    //  TODO: rimet not work
    // _textEditingController.text = 'com.alibaba.android.rimet';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              ListTile(
                leading: const Text('bundle id:'),
                title: TextField(
                  controller: _textEditingController,
                ),
                trailing: TextButton(
                  onPressed: _launch,
                  child: const Text('Launch'),
                ),
              ),
              ListTile(
                leading: const Text('openSystemSetting'),
                trailing: TextButton(
                  onPressed: _openSystemSetting,
                  child: const Text('open'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
