import 'package:chat_demo/common/user_info/user_info.dart';
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
                onPressed: () {
                  ref
                      .read(userInfoNotifierProvider.notifier)
                      .setUserInfo(
                        UserInfo(
                          id: idController.text,
                          name: nameController.text,
                        ),
                      );
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
