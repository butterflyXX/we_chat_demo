part of 'blue_service.dart';

class _BleDeviceConnector {
  StreamSubscription<ConnectionStateUpdate>? _connection;

  Future<void> connect(String deviceId) async {
    llPrint('Start connecting to $deviceId');
    await _connection?.cancel();
    final Completer<void> completer = Completer<void>();
    _connection = readProvider(_bleProvider)
        .connectToDevice(id: deviceId)
        .listen(
          (update) {
            if (update.connectionState == DeviceConnectionState.connected) {
              if (!completer.isCompleted) {
                completer.complete();
              }
            }
          },
          onError: (Object e) {
            llPrint('Connecting to device $deviceId resulted in error $e');
            if (!completer.isCompleted) {
              completer.completeError(e);
            }
          },
        );
    await completer.future;
    serviceLocator<KvManagerBase>().set(
      KvKey.connectedDevice,
      value: jsonEncode(toJson(readProvider(blueDevicesProvider).firstWhere((element) => element.id == deviceId))),
    );
  }

  Future<void> disconnect(String deviceId) async {
    try {
      llPrint('disconnecting to device: $deviceId');
      await _connection?.cancel();
    } on Exception catch (e, _) {
      llPrint("Error disconnecting from a device: $e");
    }
  }

  void restoreConnectDevice() {
    final dString = serviceLocator<KvManagerBase>().get(KvKey.connectedDevice);
    if (dString == null) return;
    final device = fromJson(jsonDecode(dString));
    readProvider(blueDevicesProvider.notifier).state = [device];
  }

  // 序列化为 Map
  Map<String, dynamic> toJson(DiscoveredDevice device) {
    return {
      'id': device.id,
      'name': device.name,
      'rssi': device.rssi,
      'connectable': device.connectable.toString(),
      'serviceUuids': device.serviceUuids.map((uuid) => uuid.toString()).toList(),
      'serviceData': device.serviceData.map((key, value) => MapEntry(key.toString(), value.toList())),
      'manufacturerData': device.manufacturerData.toList(),
    };
  }

  // 从 Map 反序列化
  DiscoveredDevice fromJson(Map<String, dynamic> map) {
    return DiscoveredDevice(
      id: map['id'] as String,
      name: map['name'] as String,
      rssi: map['rssi'] as int,
      connectable: Connectable.values.firstWhere(
        (e) => e.toString() == map['connectable'],
        orElse: () => Connectable.unknown,
      ),
      serviceUuids: (map['serviceUuids'] as List).map((uuidStr) => Uuid.parse(uuidStr as String)).toList(),
      serviceData: (map['serviceData'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(Uuid.parse(key), Uint8List.fromList((value as List).cast<int>())),
      ),
      manufacturerData: Uint8List.fromList((map['manufacturerData'] as List).cast<int>()),
    );
  }

  Future<void> dispose() async {
    await _connection?.cancel();
  }
}
