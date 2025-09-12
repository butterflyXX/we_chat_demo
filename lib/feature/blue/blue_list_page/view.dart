import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/services/blue_service/blue_service.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlueListPage extends ConsumerStatefulWidget {
  const BlueListPage({super.key});

  @override
  ConsumerState<BlueListPage> createState() => _BlueListPageState();
}

class _BlueListPageState extends ConsumerState<BlueListPage> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(blueDevicesProvider);
    return Scaffold(
      appBar: commonAppbar(
        context,
        title: 'Blue List',
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return CommonIconButton(
                onTap: () {
                  serviceLocator.get<BlueService>().startScan(timeout: const Duration(seconds: 10));
                },
                child: ref.watch(blueDevicesScanning)
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          strokeCap: StrokeCap.round,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(Icons.refresh),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return DeviceItem(device: list[index]);
        },
        itemCount: list.length,
      ),
    );
  }
}

class DeviceItem extends ConsumerWidget {
  final DiscoveredDevice device;
  const DeviceItem({super.key, required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(device.name),
      trailing: _trailing(ref.watch(blueDevicesConnectStateProvider)[device.id] == DeviceConnectionState.connected),
      onTap: () {
        llPrint(device.id);
        if (ref.watch(blueDevicesConnectStateProvider)[device.id] == DeviceConnectionState.connected) {
          serviceLocator.get<BlueService>().disconnect(device.id);
          // serviceLocator.get<BlueService>().connect(device.id);
        } else {
          serviceLocator.get<BlueService>().connect(device.id);
        }
      },
    );
  }

  Widget _trailing(bool connected) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(color: connected ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(8)),
    );
  }
}
