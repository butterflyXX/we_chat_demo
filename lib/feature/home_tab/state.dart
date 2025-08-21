import 'package:chat_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:chat_demo/common/typedef.dart';
import 'package:chat_demo/feature/contact/view.dart';
import 'package:chat_demo/feature/find/view.dart';
import 'package:chat_demo/feature/home/view.dart';
import 'package:chat_demo/feature/mine/view.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

class TabBarItem {
  final Icon icon;
  final Icon activeIcon;
  final String title;
  final CommonWidgetBuilder builder;

  TabBarItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.builder,
  });
}

@riverpod
class HomeBarState extends _$HomeBarState {
  final controller = PageController();

  @override
  int build() {
    return 0;
  }

  void changePage(int index) {
    state = index;
    controller.jumpToPage(index);
  }
}
