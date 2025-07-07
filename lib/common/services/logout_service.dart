import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_demo/common/mqtt/chat_manager.dart';
import 'package:chat_demo/common/user_info/user_info.dart';
import 'package:chat_demo/route/route.dart';

// 退出登录服务提供者
final logoutServiceProvider = Provider<LogoutService>((ref) {
  return LogoutService(ref);
});

// 退出登录服务
class LogoutService {
  final Ref ref;

  LogoutService(this.ref);

  // 执行退出登录
  Future<void> logout() async {
    try {
      debugPrint('开始退出登录...');

      // 1. 断开MQTT连接（会自动发送离线状态）
      final chatManager = ref.read(chatManagerProvider);
      await chatManager.disconnect();
      debugPrint('MQTT连接已断开');

      // 2. 清理MQTT相关资源
      chatManager.dispose();
      debugPrint('MQTT资源已清理');

      // 3. 清除用户信息
      ref.read(userInfoNotifierProvider.notifier).setUserInfo(null);
      debugPrint('用户信息已清除');

      // 4. 跳转到登录页面
      router.go('/login');
      debugPrint('已跳转到登录页面');

      debugPrint('退出登录完成');
    } catch (e) {
      debugPrint('退出登录时发生错误: $e');

      // 即使出错也要清除用户信息并跳转到登录页面
      try {
        ref.read(userInfoNotifierProvider.notifier).setUserInfo(null);
        router.go('/login');
      } catch (e2) {
        debugPrint('强制跳转到登录页面失败: $e2');
      }
    }
  }

  // 强制退出登录（用于应用被强制关闭等场景）
  Future<void> forceLogout() async {
    try {
      // 只清除本地数据，不等待网络操作
      ref.read(userInfoNotifierProvider.notifier).setUserInfo(null);

      // 尝试断开MQTT连接，但不等待
      final chatManager = ref.read(chatManagerProvider);
      chatManager.disconnect().catchError((e) {
        debugPrint('强制退出时断开MQTT连接失败: $e');
      });

      chatManager.dispose();
      debugPrint('强制退出登录完成');
    } catch (e) {
      debugPrint('强制退出登录失败: $e');
    }
  }
}
