import 'package:shared_preferences/shared_preferences.dart';

enum KvKey<T> {
  userInfo<String>(false),
  locale<String>(false);
  final bool value;

  const KvKey(this.value);
}

abstract class KvManagerBase {
  T? get<T>(KvKey<T> kvKey);

  Future<bool> set<T>(KvKey<T> kvKey, {T? value});

  Future<bool> remove(KvKey kvKey);
}

class KvManager extends KvManagerBase {
  final SharedPreferences sp;
  KvManager(this.sp);

  @override
  T? get<T>(KvKey<T> kvKey) {
    try {
      return sp.get(kvKey.name) as T?;
    } catch (_) {}
    return null;
  }

  @override
  Future<bool> set<T>(KvKey<T> kvKey, {T? value}) {
    if (value == null) {
      return remove(kvKey);
    }
    return switch (value) {
      String _ => sp.setString(kvKey.name, value),
      bool _ => sp.setBool(kvKey.name, value),
      int _ => sp.setInt(kvKey.name, value),
      double _ => sp.setDouble(kvKey.name, value),
      List<String> _ => sp.setStringList(kvKey.name, value),
      _ => throw ArgumentError("Unsupported type: ${value.runtimeType}"),
    };
  }

  @override
  Future<bool> remove(KvKey kvKey) async {
    try {
      return sp.remove(kvKey.name);
    } catch (_) {
      return false;
    }
  }

}