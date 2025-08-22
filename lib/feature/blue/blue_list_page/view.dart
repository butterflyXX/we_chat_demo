// import 'package:chat_demo/common/common.dart';
// import 'package:chat_demo/common/navigator/navigator_manager.dart';
// import 'package:chat_demo/common/services/blue_service.dart';
// import 'package:chat_demo/common/widget/app_bar.dart';
// import 'package:chat_demo/common/widget/button/icon_button.dart';
// import 'package:chat_demo/feature/blue/blue_list_page/view_model.dart';
// import 'package:chat_demo/route/route.dart';
// import 'package:chat_demo/service_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class BlueListPage extends ConsumerStatefulWidget {
//   const BlueListPage({super.key});

//   @override
//   ConsumerState<BlueListPage> createState() => _BlueListPageState();
// }

// class _BlueListPageState extends ConsumerState<BlueListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final list = ref.watch(blueDevicesProvider);
//     return Scaffold(
//       appBar: commonAppbar(
//         context,
//         title: 'Blue List',
//         actions: [
//           CommonIconButton(
//             onTap: () {
//               serviceLocator.get<BlueService>().scanDevices();
//             },
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return DeviceItem(result: list[index]);
//           },
//           itemCount: list.length,
//       ),
//     );
//   }
// }

// class DeviceItem extends StatelessWidget {
//   final ScanResult result;
//   const DeviceItem({super.key, required this.result});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(result.device.name),
//       onTap: () {
//         NavigatorManager.push(BluePageRoute(deviceId: result.device.id.toString()));
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

class BlueListPage extends StatelessWidget {
  const BlueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}