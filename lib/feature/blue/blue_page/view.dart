import 'dart:async';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/feature/blue/blue_list_page/view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluePage extends ConsumerStatefulWidget {
  final String deviceId;
  const BluePage({super.key, required this.deviceId});

  @override
  ConsumerState<BluePage> createState() => _BluePageState();
}

class _BluePageState extends ConsumerState<BluePage> {
  static const String _serviceUUID = "99786365-6c70-6f69-6e74-2e636f820000";
  static const String _serviceOtaUUID = "04000400-0000-1000-8000-009078563412";

  static const String _commandServiceUUID = "99786365-6c70-6f69-6e74-2e636f820000";

  static const String _writeUUID = "99786365-6c70-6f69-6e74-2e636f820002";

  static const String _readUUID = "99786365-6c70-6f69-6e74-2e636f820001";

  static const String _pushUUID = "99786365-6c70-6f69-6e74-2e636f820003";

  late BluetoothDevice _device;
  bool _connecting = false;
  StreamSubscription<List<int>>? _readCharacteristicStreamSubscription;
  @override
  void initState() {
    super.initState();
    _device = ref
        .read(blueDevicesProvider)
        .firstWhere((element) => element.device.id.toString() == widget.deviceId)
        .device;
    _ensureConnected().then((value) {
      if (value) {
        llPrint("连接成功");


      } else {
        llPrint("连接失败");
        _device.disconnect();
      }
    });
  }

  void _connectDevice() {
    _device = ref
        .read(blueDevicesProvider)
        .firstWhere((element) => element.device.id.toString() == widget.deviceId)
        .device;
    final device = _device;
    if (device == null) {
      return;
    }
    int count = 0;
    final streamSubscription = device.state.listen((event) {
      llPrint("connectDevice event  $event");
      if (count > 0 && event == BluetoothDeviceState.disconnected) {
        llPrint("connectDevice 连接失败");
        return;
      } else if (event == BluetoothDeviceState.disconnected) {
        device.connect();
      } else if (event == BluetoothDeviceState.connected) {
        llPrint("connectDevice 连接成功");
      }
      count++;
    });

    return;
  }

  Future<bool> _ensureConnected() async {
    final device = _device;
    // 1. 检查连接状态
    final s = await device.state.first;
    llPrint("ensureConnected s: $s");
    if (s == BluetoothDeviceState.disconnected && !_connecting) {
      llPrint("connecting...");
      _connecting = true;
      try {
        await device.connect(timeout: const Duration(seconds: 10), autoConnect: false);
      } catch (e) {
        llPrint("ensureConnected error: $e");
        return false;
      } finally {
        _connecting = false;
      }
    }

    // 2. 尝试发现服务
    List<BluetoothService> serviceList;
    try {
      serviceList = await device.discoverServices();
    } catch (e) {
      llPrint("discoverServices failed: $e");
      return false;
    }

    if (serviceList.isEmpty) {
      llPrint("services 列表为空");
      return false;
    }
    
    final targetService = serviceList.firstWhereOrNull((element) => element.uuid.toString() == _serviceUUID);
    final commandService = serviceList.firstWhereOrNull((element) => element.uuid.toString() == _commandServiceUUID);
    final otaService = serviceList.firstWhereOrNull((element) => element.uuid.toString() == _serviceOtaUUID);

    if (targetService == null) {
      llPrint("未找到目标服务");
      return false;
    }

    if (commandService == null) {
      llPrint("未找到command服务");
      return false;
    }

    final _readCharacteristic = commandService.characteristics.firstWhereOrNull(
      (element) => element.uuid.toString() == _readUUID,
    );

    // if (_writeCharacteristic == null) {
    //   llPrint("_writeCharacteristic null");
    //   return false;
    // } else {
    //   llPrint("_writeCharacteristic ${_writeCharacteristic.properties.read} ${_writeCharacteristic.properties.write}");
    // }

    if (_readCharacteristic == null) {
      llPrint("_readCharacteristic null");
      return false;
    } else {
      llPrint("_readCharacteristic ${_readCharacteristic.properties.read} ${_readCharacteristic.properties.write}");
    }

    try {
      final res = await _readCharacteristic.setNotifyValue(true);
      if (res) {
        llPrint("订阅成功");
      } else {
        llPrint("订阅失败");
        return false;
      }
    } on Exception catch (e) {
      llPrint("_readCharacteristic  exception: $e");
      return false;
    }

    llPrint("连接验证完成，所有测试通过");
    return true;
  }

  @override
  void dispose() {
    _readCharacteristicStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_device == null) {
      return Scaffold(
        appBar: commonAppbar(context, title: '加载中...'),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(appBar: commonAppbar(context, title: _device!.name));
  }
}
