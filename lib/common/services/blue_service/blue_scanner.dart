part of 'blue_service.dart';

class _BleScanner {
  StreamSubscription<DiscoveredDevice>? _subscription;

  Timer? _scanTimer;

  void startScan(List<Uuid> serviceIds, {Duration? timeout}) async {
    llPrint('Start ble discovery');
    readProvider(blueDevicesProvider.notifier).state = [];
    await stopScan();

    _subscription = readProvider(_bleProvider)
        .scanForDevices(withServices: serviceIds)
        .listen(
          (device) {
            final deivceName = device.name;
            if (!deivceName.toLowerCase().contains("leionhey2") && !deivceName.toLowerCase().contains("leion hey2")) {
              return;
            }
            var devices = readProvider(blueDevicesProvider);
            final knownDeviceIndex = devices.indexWhere((d) => d.id == device.id);
            if (knownDeviceIndex >= 0) {
              devices[knownDeviceIndex] = device;
            } else {
              devices.add(device);
            }
            readProvider(blueDevicesProvider.notifier).state = List.from(devices);
          },
          onError: (Object e) {
            stopScan();
            llPrint('Device scan fails with error: $e');
          },
        );
    readProvider(blueDevicesScanning.notifier).state = true;
    if (timeout != null) _scanTimer = Timer(timeout, stopScan);
  }

  Future<void> stopScan() async {
    llPrint('Stop ble discovery');
    _scanTimer?.cancel();
    _scanTimer = null;

    await _subscription?.cancel();
    _subscription = null;
    readProvider(blueDevicesScanning.notifier).state = false;
  }

  Future<void> dispose() async {}
}
