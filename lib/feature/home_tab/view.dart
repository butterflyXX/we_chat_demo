import 'package:chat_demo/feature/contact/view.dart';
import 'package:chat_demo/feature/find/view.dart';
import 'package:chat_demo/feature/home/view.dart';
import 'package:chat_demo/feature/mine/view.dart';
import 'package:chat_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/feature/home_tab/state.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBars = getTabBars(context);
    final state = ref.read(homeBarStateProvider.notifier);
    return Scaffold(
      body: PageView.builder(
        controller: state.controller,
        itemCount: tabBars.length,
        itemBuilder: (context, index) {
          return tabBars[index].builder();
        },
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(homeBarStateProvider);
          return BottomNavigationBar(
            currentIndex: index,
            selectedItemColor: selectedTabBarItemColor,
            unselectedItemColor: unselectedTabBarItemColor,
            backgroundColor: commonAppBarBackColor,
            unselectedFontSize: 10.sp,
            selectedFontSize: 10.sp,
            iconSize: 22.w,
            type: BottomNavigationBarType.fixed,
            onTap: state.changePage,
            items: tabBars.map((item) {
              return BottomNavigationBarItem(
                icon: item.icon,
                activeIcon: item.activeIcon,
                label: item.title,
              );
            }).toList(),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  List<TabBarItem> getTabBars(BuildContext context) {
    List<TabBarItem> tabBars = [];
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.message_circle),
        activeIcon: const Icon(LucideIcons.message_circle),
        title: S.of(context).home_tab_chat,
        builder: () {
          return const Home();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.contact),
        activeIcon: const Icon(LucideIcons.contact),
        title: S.of(context).home_tab_contact,
        builder: () {
          return const Contact();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.text_search),
        activeIcon: const Icon(LucideIcons.text_search),
        title: S.of(context).home_tab_find,
        builder: () {
          return const Find();
        },
      ),
    );
    tabBars.add(
      TabBarItem(
        icon: const Icon(LucideIcons.user),
        activeIcon: const Icon(LucideIcons.user),
        title: S.of(context).home_tab_mine,
        builder: () {
          return const Mine();
        },
      ),
    );
    return tabBars;
  }
}
