import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/config/mqtt_config.dart';
import 'package:chat_demo/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: idController,
            decoration: const InputDecoration(labelText: 'id'),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  final userInfo = UserInfo(
                    id: idController.text,
                    name: nameController.text,
                  );

                  // 设置用户信息
                  ref
                      .read(userInfoNotifierProvider.notifier)
                      .setUserInfo(userInfo);

                  // 初始化 ChatManager
                  try {
                    final chatManager = ref.read(chatManagerProvider);
                    await chatManager.initialize(
                      userId: userInfo.id,
                      userName: userInfo.name,
                      userAvatar: '', // 当前没有头像信息
                      broker: MqttConfig.defaultBroker,
                      port: MqttConfig.defaultPort,
                      username: MqttConfig.defaultUsername,
                      password: MqttConfig.defaultPassword,
                    );

                    // 连接到 MQTT 服务器
                    await chatManager.connect();
                  } catch (e) {
                    llPrint('MQTT 连接失败: $e');
                  }

                  // 跳转到主页
                  router.go(HomeRoute().location);
                },
                child: const Text('Login'),
              );
            },
          ),
        ],
      ),
    );
  }
}
