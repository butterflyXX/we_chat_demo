import 'dart:io';

import 'package:chat_demo/common/providers/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/common.dart';
import 'package:chat_demo/common/widget/app_bar.dart';
import 'package:chat_demo/common/widget/button/home_top_search_button.dart';
import 'package:chat_demo/common/widget/button/icon_button.dart';
import 'package:chat_demo/feature/home/state.dart';
import 'package:chat_demo/feature/home/widget/home_item_widget.dart';

class Home extends ConsumerStatefulWidget {
  static const String title = "微信";

  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 46,
              color: commonAppBarBackColor,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
              child: HomeTopSearchButton(onTap: () {}),
            ),
          ),
          ref
              .watch(userListProvider)
              .when(
                data: (data) => SliverList.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      HomeItemWidget(model: data[index]),
                ),
                error: (error, stackTrace) => SliverToBoxAdapter(),
                loading: () => const SliverToBoxAdapter(),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Directory tempDir = await getLibraryDirectory();
          for (final file in tempDir.listSync()) {
            llPrint(file);
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
