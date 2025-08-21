import 'package:chat_demo/common/kv_manager/kv_manager.dart';
import 'package:chat_demo/service_manager.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_service.g.dart';

@Riverpod(keepAlive: true)
class LocaleService extends _$LocaleService {
  @override
  Locale build() {
    final localeString = serviceLocator<KvManagerBase>().get(KvKey.locale);
    return Locale(localeString ?? 'zh');
  }

  void setLocale(Locale locale) {
    state = locale;
    serviceLocator<KvManagerBase>().set(KvKey.locale, value: locale.toString());
  }
}