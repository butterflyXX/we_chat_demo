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
        icon: const Icon(LucideIcons.message_circle),
        activeIcon: const Icon(LucideIcons.message_circle),
        title: Home.title,
        builder: () {
          return const Home();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.contact),
        activeIcon: const Icon(LucideIcons.contact),
        title: Contact.title,
        builder: () {
          return const Contact();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.text_search),
        activeIcon: const Icon(LucideIcons.text_search),
        title: Find.title,
        builder: () {
          return const Find();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.user),
        activeIcon: const Icon(LucideIcons.user),
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
