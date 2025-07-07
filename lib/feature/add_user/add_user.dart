import 'package:chat_demo/common/navigator/navigator_manager.dart';
import 'package:chat_demo/common/providers/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
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
                  ref
                      .read(userListProvider.notifier)
                      .addUser(idController.text, nameController.text);
                  NavigatorManager.pop();
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
