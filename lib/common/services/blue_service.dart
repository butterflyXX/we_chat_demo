import 'package:flutter_blue/flutter_blue.dart';
import 'dart:io';

class BlueService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> scanDevices() async {
    try {
      // 先停止之前的扫描
      await flutterBlue.stopScan();
      
      // iOS需要更长的扫描时间来发现之前连接过的设备
      await flutterBlue.startScan(
        timeout: const Duration(seconds: 30), // 增加扫描时间
        scanMode: ScanMode.lowLatency, // 使用低延迟模式
      );
      
      print('蓝牙扫描已开始，扫描时间30秒');
    } catch (e) {
      print('蓝牙扫描失败: $e');
    }
  }

  // 强制刷新扫描 - 专门用于发现断开后重新连接的设备
  Future<void> forceRefreshScan() async {
    try {
      await flutterBlue.stopScan();
      
      // 等待系统清理缓存
      await Future.delayed(const Duration(seconds: 3));
      
      // 使用更长的扫描时间
      await flutterBlue.startScan(
        timeout: const Duration(seconds: 45),
        scanMode: ScanMode.lowLatency,
      );
      
      print('强制刷新蓝牙扫描已开始，扫描时间45秒');
    } catch (e) {
      print('强制刷新蓝牙扫描失败: $e');
    }
  }

  // 检查蓝牙状态
  Future<bool> isBluetoothAvailable() async {
    try {
      final state = await flutterBlue.state.first;
      return state == BluetoothState.on;
    } catch (e) {
      print('检查蓝牙状态失败: $e');
      return false;
    }
  }

  // 获取已连接的设备
  Future<List<BluetoothDevice>> getConnectedDevices() async {
    try {
      return await flutterBlue.connectedDevices;
    } catch (e) {
      print('获取已连接设备失败: $e');
      return [];
    }
  }

  // 检测蓝牙版本支持
  String getBluetoothVersionSupport() {
    if (Platform.isIOS) {
      // iOS设备蓝牙版本支持
      // 注意：Flutter Blue插件不直接提供蓝牙版本信息
      // 这里提供的是基于iOS版本的估算
      return 'iOS设备通常支持蓝牙4.0-5.3，具体取决于设备型号';
    } else if (Platform.isAndroid) {
      return 'Android设备蓝牙版本取决于硬件';
    }
    return '未知平台';
  }

  // 获取设备信息
  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final state = await flutterBlue.state.first;
      final connectedDevices = await flutterBlue.connectedDevices;
      
      return {
        'bluetoothState': state.toString(),
        'connectedDevicesCount': connectedDevices.length,
        'platform': Platform.operatingSystem,
        'bluetoothVersionInfo': getBluetoothVersionSupport(),
      };
    } catch (e) {
      print('获取设备信息失败: $e');
      return {};
    }
  }
}