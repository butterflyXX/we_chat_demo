import 'package:chat_demo/common/navigator/navigator_manager.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(
        context,
        title: Mine.title,
        actions: [
          CommonIconButton(
            onTap: () {
              ref.read(userInfoNotifierProvider.notifier).setUserInfo(null);
              NavigatorManager.push(LoginRoute());
              router.go('/login');
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text(Mine.title)),
    );
  }
}
