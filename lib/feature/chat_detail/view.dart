import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/common.dart';
import 'package:we_chat_demo/common/widget/app_bar.dart';
import 'package:we_chat_demo/common/widget/chat_bubble.dart';
import 'package:we_chat_demo/feature/chat_detail/state.dart';
import 'package:we_chat_demo/feature/chat_detail/widget/chat_bottom_bar.dart';
import 'package:we_chat_demo/feature/chat_detail/widget/chat_item_widget.dart';
import 'package:we_chat_demo/model/home_item_model.dart';

class ChatDetailPage extends StatefulWidget {
  final HomeItemModel model;

  const ChatDetailPage({required this.model, super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {


  late ChatDetailState state;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state.link();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ChatDetailState(),
      dispose: (context, value) {
        print(value);
      },
      builder: (context, child) {
        state = context.read<ChatDetailState>();
        return Scaffold(
          appBar: commonAppbar(context, title: widget.model.name, actions: [
            TextButton(
              onPressed: () {
                state.addTest();
              },
              child: Icon(Icons.more_horiz),
            ),
          ]),
          backgroundColor: commonAppBarBackColor,
          body: GestureDetector(
            onTap: cancelKeyBoard,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context,cons) {
                      state.jumpWithAnimation?.call(false,true);
                      return ValueListenableBuilder(
                        valueListenable: state.dataList,
                        builder: (context, list, child) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            controller: state.controller,
                            separatorBuilder: (_, __) {
                              return SizedBox(
                                height: 20,
                              );
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
                      );
                    }
                  ),
                ),
                ChatBottomBar(
                  onSubmit: (value) {
                    state.send(value);
                    // return false;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
