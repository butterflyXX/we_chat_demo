import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';
import 'package:we_chat_demo/common/widget/chat_bubble.dart';
import 'package:we_chat_demo/feature/chat_detail/state.dart';
import 'package:we_chat_demo/feature/chat_detail/widget/chat_item_widget.dart';
import 'package:we_chat_demo/model/home_item_model.dart';

class ChatDetailPage extends StatefulWidget {
  final HomeItemModel model;

  const ChatDetailPage({required this.model, super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=>ChatDetailState(),
      builder: (context,child) {
        final state = context.read<ChatDetailState>();
        return Scaffold(
          appBar: commonAppbar(context, title: widget.model.name),
          backgroundColor: commonAppBarBackColor,
          body: ValueListenableBuilder(
            valueListenable: state.dataList,
            builder: (context, list, child) {
              return ListView.separated(
                separatorBuilder: (_,__) {
                  return SizedBox(height: 20,);
                },
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final model = list[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ChatItemWidget(
                      myId: 2,
                      model: model,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
