import 'package:flutter_blue/flutter_blue.dart';

class BlueService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> scanDevices() async {
    await flutterBlue.stopScan();
    flutterBlue.startScan(timeout: const Duration(seconds: 15));
  }
}