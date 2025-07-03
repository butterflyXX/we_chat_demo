import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/feature/home_tab/state.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(homeBarStateProvider.notifier);
    return Scaffold(
      body: PageView.builder(
        controller: state.controller,
        itemCount: state.tabBars.length,
        itemBuilder: (context, index) {
          return state.tabBars[index].builder();
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
            items: state.tabBars.map((item) {
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
}
