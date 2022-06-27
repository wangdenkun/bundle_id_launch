import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bundle_id_launch/bundle_id_launch.dart';

void main() {
  const MethodChannel channel = MethodChannel('bundle_id_launch');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BundleIdLaunch.platformVersion, '42');
  });
}
