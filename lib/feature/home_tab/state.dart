import 'package:flutter/material.dart';
import 'package:chat_demo/common/typedef.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

class TabBarItem {
  final Icon icon;
  final Icon activeIcon;
  final String title;
  final CommonWidgetBuilder builder;

  TabBarItem({required this.icon, required this.activeIcon, required this.title, required this.builder});
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
