import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:collection/collection.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'blue_scanner.dart';
part 'ble_device_connector.dart';

final blueDevicesProvider = StateProvider<List<DiscoveredDevice>>((ref) {
  return [];
});

final blueDevicesScanning = StateProvider<bool>((ref) {
  return false;
});

final bleStatusProvider = StreamProvider<BleStatus?>((ref) {
  return ref.watch(_bleProvider).statusStream;
});

final _bleProvider = Provider((ref) {
  return FlutterReactiveBle();
});

final blueDevicesConnectStateProvider = StateProvider((ref) {
  return <String, DeviceConnectionState>{};
});

class BlueService {
  static const String _serviceUUID = "99786365-6c70-6f69-6e74-2e636f820000";
  // static const String _serviceOtaUUID = "04000400-0000-1000-8000-009078563412";

  static const String _commandServiceUUID = "99786365-6c70-6f69-6e74-2e636f820000";

  static const String _writeUUID = "99786365-6c70-6f69-6e74-2e636f820002";

  static const String _readUUID = "99786365-6c70-6f69-6e74-2e636f820001";

  static const String _pushUUID = "99786365-6c70-6f69-6e74-2e636f820003";

  late final _BleScanner _scanner;
  late final _BleDeviceConnector _deviceConnector;
  late final _ble = readProvider(_bleProvider);

  Characteristic? _writeCharacteristic;

  BlueService() {
    _scanner = _BleScanner();
    _deviceConnector = _BleDeviceConnector();
  }

  void init() {
    _deviceConnector.restoreConnectDevice();
    _ble.connectedDeviceStream.listen((device) {
      llPrint('connectedDeviceStream: $device');
      readProvider(blueDevicesConnectStateProvider.notifier).state = {
        ...readProvider(blueDevicesConnectStateProvider.notifier).state,
        device.deviceId: device.connectionState,
      };
    });
  }

  Future<void> startScan({Duration? timeout}) async {
    _scanner.startScan([], timeout: timeout);
  }

  Future<void> stopScan() async {
    _scanner.stopScan();
  }

  Future<void> connect(String deviceId) async {
    // 物理连接
    await _deviceConnector.connect(deviceId);

    //发现服务
    final serviceList = await _ble.getDiscoveredServices(deviceId);

    void onFail() {}

    if (serviceList.isEmpty) {
      onFail();
      return;
    }

    //寻找指定服务
    final targetService = serviceList.firstWhereOrNull((element) => element.id.toString() == _serviceUUID);
    final commandService = serviceList.firstWhereOrNull((element) => element.id.toString() == _commandServiceUUID);
    if (targetService == null) {
      onFail();
      return;
    }
    if (commandService == null) {
      onFail();
      return;
    }

    // 指令读写特征
    final readCharacteristic = commandService.characteristics.firstWhereOrNull(
      (element) => element.id.toString() == _readUUID,
    );
    _writeCharacteristic = commandService.characteristics.firstWhereOrNull(
      (element) => element.id.toString() == _writeUUID,
    );
    if (readCharacteristic == null) {
      onFail();
      return;
    }
    if (_writeCharacteristic == null) {
      onFail();
      return;
    }

    // 通知特征
    final notifyCharacteristic = targetService.characteristics.firstWhereOrNull(
      (element) => element.id.toString() == _pushUUID,
    );
    if (notifyCharacteristic == null) {
      onFail();
      return;
    }

    try {
      await readCharacteristic.read();
    } catch (e) {
      final errorString = e.toString();
      if (errorString.contains('Code=15')) {
        onFail();
        return;
      }
    }

    readCharacteristic.subscribe().listen(
      (event) {
        llPrint('readCharacteristic: $event');
      },
      onError: (e) {
        llPrint('readCharacteristic error: $e');
        onFail();
      },
    );

    notifyCharacteristic.subscribe().listen(
      (event) {
        llPrint('notifyCharacteristic: $event');
      },
      onError: (e) {
        llPrint('notifyCharacteristic error: $e');
        onFail();
      },
    );

    final map = {};
    map["type"] = 10;
    map["num"] = 12;
    sendOrder(map);
    // 订阅通知
    // await notifyCharacteristic.setNotifyValue(true);
  }

  Future sendOrder(Map data) async {
    int type = data["type"];
    int num = data["num"];
    String? argument = data["content"];

    int argumentLength = 0;
    Uint8List? argu;
    List<Uint8List> packetList = List.empty(growable: true);
    if (argument != null) {
      argu = utf8.encode(argument) as Uint8List?;
      argumentLength = argu!.length;
    }
    int packDataLength = 400;
    int packetSize = argumentLength ~/ packDataLength;
    int surplus = argumentLength % packDataLength;
    if (argumentLength > packDataLength) {
      for (int i = 0; i < packetSize; i++) {
        Uint8List send = Uint8List(packDataLength + 8);
        if (i == 0) {
          send[0] = 2;
        } else if (i == packetSize - 1 && surplus == 0) {
          send[0] = 4;
        } else {
          send[0] = 3;
        }
        send[1] = 1;
        send[2] = 1;
        send[3] = type;
        send[4] = num;
        send[5] = 1;
        send[6] = packDataLength & 0xff;
        send[7] = (packDataLength >> 8) & 0xff;
        if (argumentLength != 0) {
          send.setAll(8, argu!.sublist(i * packDataLength, (i + 1) * packDataLength));
        }
        packetList.add(send);
      }
      if (surplus > 0) {
        Uint8List send = Uint8List(surplus + 8);
        send[0] = 4;
        send[1] = 1;
        send[2] = 1;
        send[3] = type;
        send[4] = num;
        send[5] = 1;
        send[6] = surplus & 0xff;
        send[7] = (surplus >> 8) & 0xff;
        send.setAll(8, argu!.sublist(packetSize * packDataLength));
        packetList.add(send);
      }
    } else {
      Uint8List send = Uint8List(8 + argumentLength);
      send[0] = 1;
      send[1] = 1;
      send[2] = 1;
      send[3] = type;
      send[4] = num;
      send[5] = 1;
      send[6] = argumentLength & 0xff;
      send[7] = (argumentLength >> 8) & 0xff;
      if (argumentLength != 0) {
        send.setAll(8, utf8.encode(argument!));
      }
      packetList.add(send);
    }
    llPrint("sendOrder  分包数量 ${packetList.length}");
    for (int i = 0; i < packetList.length; i++) {
      await _sendOrder(packetList[i]);
    }

    return;
  }

  Future _sendOrder(Uint8List data) async {
    if (_writeCharacteristic == null) {
      llPrint("_writeCharacteristic is null");
      return;
    }
    if (readProvider(blueDevicesConnectStateProvider)[_writeCharacteristic!.service.deviceId] !=
        DeviceConnectionState.connected) {
      llPrint("设备未连接，无法发送指令");
      return;
    }
    await _writeCharacteristic!.write(data);
    return;
  }

  Future<void> disconnect(String deviceId) async {
    await _deviceConnector.disconnect(deviceId);
  }
}
