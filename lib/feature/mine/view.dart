import 'package:chat_demo/common/navigator/navigator_manager.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/common/services/logout_service.dart';
import 'package:chat_demo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mine extends ConsumerStatefulWidget {
  static const String title = "我的";
  const Mine({super.key});

  @override
  ConsumerState<Mine> createState() => _MineState();
}

class _MineState extends ConsumerState<Mine> {
  // 退出登录方法
  Future<void> _logout() async {
    final logoutService = ref.read(logoutServiceProvider);
    await logoutService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(
        context,
        title: Mine.title,
        actions: [
          CommonIconButton(onTap: _logout, child: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Blue List'),
            onTap: () {
              NavigatorManager.push(BlueListRoute());
            },
          ),
        ],
      ),
    );
  }
}
