import 'package:flutter/material.dart';
import 'package:chat_demo/common/typedef.dart';
import 'package:chat_demo/feature/contact/view.dart';
import 'package:chat_demo/feature/find/view.dart';
import 'package:chat_demo/feature/home/view.dart';
import 'package:chat_demo/feature/mine/view.dart';
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

@Riverpod(keepAlive: true)
class HomeBarState extends _$HomeBarState {
  PageController controller = PageController();
  List<TabBarItem> tabBars = [];

  @override
  int build() {
    initPage();
    return 0;
  }

  void initPage() {
    tabBars.add(
      TabBarItem(
        icon: const Icon(Icons.chat_bubble_outline),
        activeIcon: const Icon(Icons.chat_bubble),
        title: Home.title,
        builder: () {
          return const Home();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(Icons.people_outline),
        activeIcon: const Icon(Icons.people),
        title: Contact.title,
        builder: () {
          return const Contact();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(Icons.find_in_page_outlined),
        activeIcon: const Icon(Icons.find_in_page),
        title: Find.title,
        builder: () {
          return const Find();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(Icons.call_outlined),
        activeIcon: const Icon(Icons.call),
        title: Mine.title,
        builder: () {
          return const Mine();
        },
      ),
    );
  }

  void changePage(int index) {
    state = index;
    controller.jumpToPage(index);
  }
}
