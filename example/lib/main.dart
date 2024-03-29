import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bundle_id_launch/bundle_id_launch.dart';
import 'package:url_launcher/url_launcher.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> _launch() async{
    var bundleId = _textEditingController.text;
    if (bundleId.isEmpty) return;
    var res = await BundleIdLaunch.launch(bundleId: bundleId);
    debugPrint('---> _MyAppState._launch res: $res');
  }
  Future<void> _openSystemSetting() async{
    await BundleIdLaunch.openSystemSetting();
  }
  Future<void> _hasInstall() async{
    var bundleId = _textEditingController.text;
    var res = await BundleIdLaunch.hasInstall(bundleId: bundleId);
    debugPrint('---> _MyAppState._hasInstall res: $res');
  }
  Future<bool> _launchiOSApp({required String url}) async{
    return await BundleIdLaunch.launchByUrlScheme(url: url);
  }

  @override
  Widget build(BuildContext context) {
    // _textEditingController.text = 'com.alibaba.android.rimet';
    // _textEditingController.text = 'ai.mushi.switcher';
    // _textEditingController.text = 'com.tencent.wemeet.controller';
    // _textEditingController.text = 'us.zoom.zrc';
    _textEditingController.text = 'com.bytedance.viewroom.controller';
    // _textEditingController.text = 'us.zoom.zrcc';
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
              ),
              ListTile(
                leading: const Text('hasInstall'),
                trailing: TextButton(
                  onPressed: _hasInstall,
                  child: const Text('check'),
                ),
              ),
              ListTile(
                leading: const Text('飞书 fs-controller://'),
                onTap: (){
                  _launchiOSApp(url: 'fs-controller://');
                },
              ),
              ListTile(
                leading: const Text('腾讯 tmrctrl://'),
                onTap: (){
                  _launchiOSApp(url: 'tmrctrl://');
                },
              ),
              ListTile(
                leading: const Text('umeet umeetrooms://'),
                onTap: (){
                  _launchiOSApp(url: 'umeetrooms://');
                },
              ),
              ListTile(
                leading: const Text('Zoom zoomrooms://'),
                onTap: (){
                  _launchiOSApp(url: 'zoomrooms://');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
