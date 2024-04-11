import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';
import 'package:we_chat_demo/feature/home_tab/state.dart';
import 'package:we_chat_demo/route/route_builder.dart';

class HomeTab extends StatelessWidget with Routable {
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=>HomeBarState(),
      builder: (context, child) {
        final state = context.read<HomeBarState>();
        return Scaffold(
          body: PageView.builder(
            controller: state.controller,
            itemCount: state.tabBars.length,
            itemBuilder: (context, index) {
              return state.tabBars[index].builder();
            },
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: state.currentIndex,
            builder: (context,index,child) {
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
                  return BottomNavigationBarItem(icon: item.icon,activeIcon: item.activeIcon,label: item.title);
                }).toList(),
              );
            }
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
