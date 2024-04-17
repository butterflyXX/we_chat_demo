import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';
import 'package:we_chat_demo/common/widget/button/home_top_search_button.dart';
import 'package:we_chat_demo/common/widget/button/icon_button.dart';
import 'package:we_chat_demo/feature/home/state.dart';
import 'package:we_chat_demo/feature/home/widget/home_item_widget.dart';

class Home extends StatefulWidget {
  static const String title = "微信";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Provider(
        create: (context) => HomeState(context),
        builder: (context, child) {
          final state = context.read<HomeState>();
          return Scaffold(
            appBar: commonAppbar(
              context,
              title: Home.title,
              actions: [
                CommonIconButton(
                  onTap: () {},
                  child: const Icon(Icons.add_circle_outline),
                ),
              ],
              leading: CommonIconButton(
                onTap: () {},
                child: const Icon(Icons.more_horiz),
              ),
            ),
            backgroundColor: Colors.white,
            body: ValueListenableBuilder(
              valueListenable: state.dataList,
              builder: (context, list, child) {
                return ListView.builder(
                  itemCount: 1 + list.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return child;
                    } else {
                      final model = list[index - 1];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          state.gotoChatDetail(model);
                        },
                        child: HomeItemWidget(model: model),
                      );
                    }
                  },
                );
              },
              child: Container(
                height: 46,
                color: commonAppBarBackColor,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                child: HomeTopSearchButton(
                  onTap: () {},
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final Directory tempDir = await getLibraryDirectory();
                for(final file in tempDir.listSync()) {
                  print(file);
                }
              },
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
