import 'package:flutter/material.dart';
import 'package:chat_demo/common/typedef.dart';
import 'package:chat_demo/feature/contact/view.dart';
import 'package:chat_demo/feature/find/view.dart';
import 'package:chat_demo/feature/home/view.dart';
import 'package:chat_demo/feature/mine/view.dart';

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

class HomeBarState {
  PageController controller = PageController();
  List<TabBarItem> tabBars = [];
  ValueNotifier currentIndex = ValueNotifier(0);

  HomeBarState() {
    initPage();
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
    currentIndex.value = index;
    controller.jumpToPage(index);
  }
}
