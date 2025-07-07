import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_demo/common/services/logout_service.dart';

// 应用生命周期服务提供者
final appLifecycleServiceProvider = Provider<AppLifecycleService>((ref) {
  return AppLifecycleService(ref);
});

// 应用生命周期管理器
class AppLifecycleService extends WidgetsBindingObserver {
  final Ref ref;

  AppLifecycleService(this.ref);

  // 初始化生命周期监听
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  // 清理生命周期监听
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // 应用恢复到前台
        debugPrint('应用恢复到前台');
        break;

      case AppLifecycleState.paused:
        // 应用进入后台
        debugPrint('应用进入后台');
        break;

      case AppLifecycleState.detached:
        // 应用被分离（即将被系统杀死）
        debugPrint('应用被分离，执行强制退出登录');
        _handleAppDetached();
        break;

      case AppLifecycleState.inactive:
        // 应用处于非活动状态
        debugPrint('应用处于非活动状态');
        break;

      case AppLifecycleState.hidden:
        // 应用隐藏
        debugPrint('应用隐藏');
        break;
    }
  }

  // 处理应用被分离的情况
  void _handleAppDetached() {
    try {
      // 执行强制退出登录，不等待结果
      final logoutService = ref.read(logoutServiceProvider);
      logoutService.forceLogout();
    } catch (e) {
      debugPrint('处理应用分离时发生错误: $e');
    }
  }
}
