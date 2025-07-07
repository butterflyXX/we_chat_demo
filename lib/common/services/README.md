# 退出登录和MQTT连接管理

## 概述

本项目实现了完整的退出登录和MQTT连接管理系统，确保用户在退出登录时能够正确断开MQTT连接并发送离线状态。

## 核心组件

### 1. LogoutService (退出登录服务)
- **位置**: `lib/common/services/logout_service.dart`
- **功能**: 管理完整的退出登录流程
- **方法**:
  - `logout()`: 正常退出登录
  - `forceLogout()`: 强制退出登录（用于应用被强制关闭）

### 2. AppLifecycleService (应用生命周期管理)
- **位置**: `lib/common/services/app_lifecycle_service.dart`
- **功能**: 监听应用生命周期变化
- **触发时机**: 当应用被系统分离时自动执行强制退出登录

### 3. ChatManager (聊天管理器)
- **位置**: `lib/common/mqtt/chat_manager.dart`
- **功能**: 管理MQTT聊天功能
- **新增方法**: `disconnect()` - 断开MQTT连接

### 4. MqttService (MQTT服务)
- **位置**: `lib/common/mqtt/mqtt_service.dart`
- **功能**: 核心MQTT连接管理
- **增强**: 在断开连接时自动发送离线状态

## 退出登录流程

### 正常退出登录
```
用户点击退出按钮
    ↓
调用 LogoutService.logout()
    ↓
1. 断开MQTT连接（发送离线状态）
    ↓
2. 清理MQTT资源
    ↓
3. 清除用户信息
    ↓
4. 跳转到登录页面
```

### 强制退出登录
```
应用被系统分离
    ↓
AppLifecycleService 监听到状态变化
    ↓
调用 LogoutService.forceLogout()
    ↓
1. 清除用户信息
    ↓
2. 异步断开MQTT连接
    ↓
3. 清理资源
```

## 为什么需要断开MQTT连接

### 1. 资源管理
- 释放网络连接资源
- 清理内存占用
- 停止后台任务

### 2. 用户状态管理
- 向其他用户发送离线状态
- 停止接收消息
- 清理消息缓存

### 3. 安全考虑
- 防止未授权的消息接收
- 确保会话完全结束
- 清理敏感数据

### 4. 用户体验
- 其他用户能看到正确的在线状态
- 避免"僵尸连接"
- 保证下次登录时的状态一致性

## 实现细节

### 1. MQTT离线状态发送
```dart
// 在断开连接时发送离线状态
await _publishUserStatus('offline');
```

### 2. 错误处理
```dart
try {
  await normalLogout();
} catch (e) {
  // 即使出错也要跳转到登录页面
  router.go('/login');
}
```

### 3. 应用生命周期监听
```dart
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.detached) {
    // 应用被分离，执行强制退出登录
    _handleAppDetached();
  }
}
```

## 使用方法

### 1. 在页面中使用退出登录
```dart
// 在任何页面中
final logoutService = ref.read(logoutServiceProvider);
await logoutService.logout();
```

### 2. 在main.dart中初始化生命周期管理
```dart
// 已在main.dart中自动初始化
class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lifecycleService = ref.read(appLifecycleServiceProvider);
      _lifecycleService?.initialize();
    });
  }
}
```

## 最佳实践

### 1. 退出登录时机
- 用户主动退出
- 令牌过期
- 应用被强制关闭
- 网络长时间断开

### 2. 错误处理
- 网络断开时的重试机制
- 超时处理
- 异常情况的兜底方案

### 3. 状态同步
- 确保UI状态与实际状态一致
- 防止状态不一致导致的问题
- 提供用户反馈

## 测试场景

### 1. 正常退出
- 点击退出按钮
- 验证MQTT连接断开
- 验证跳转到登录页面

### 2. 应用被杀死
- 强制关闭应用
- 验证离线状态发送
- 验证资源清理

### 3. 网络异常
- 断开网络后退出
- 验证本地清理
- 验证下次登录状态

## 注意事项

1. **异步操作**: 退出登录是异步操作，需要适当的加载指示
2. **网络依赖**: 发送离线状态需要网络连接
3. **时间限制**: 应用被强制关闭时，可用时间有限
4. **状态一致性**: 确保UI状态与实际登录状态一致

## 扩展功能

1. **自动重连**: 网络恢复后自动重连
2. **状态持久化**: 保存用户状态到本地
3. **多设备管理**: 管理多设备登录状态
4. **会话管理**: 更精细的会话控制 