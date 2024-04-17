import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:we_chat_demo/model/chat_item_model.dart';

typedef JumpCallBack<T> = void Function(bool animation,bool nextFrame);

class ChatDetailState {
  final ValueNotifier<List<ChatItemModel>> dataList = ValueNotifier([]);
  final ScrollController controller = ScrollController();

  JumpCallBack? jumpWithAnimation;

  ChatDetailState() {
    loadData();
  }

  List<String> test = [
    "1你好!",
    "2你是?",
    "1我是boss直聘的HR,收到您的简历想了解一下",
    "2哦,请问是什么岗位,我是iOS方向的,可以做flutter或者iOS原生",
    "1我们这个岗位是杀猪的",
    "1要求会C++,JAVA,以及小程序",
    "1您这边有实际的杀猪经验吗?",
    "1有没有已经上线的猪",
    "2有的,杀过的猪目前上线有5,6个了,有纯原生的猪还有和flutter混编的猪,原生与flutter占比在50%左右",
    "1好的,我已将您的简历发送至用人部门,后续初筛通过,我们会联系您!!!",
    "1好的,我已将您的简历发送至用人部门,后续初筛通过,我们会联系您!!!",
    "1好的,我已将您的简历发送至用人部门,后续初筛通过,我们会联系您!!!",
    "1好的,我已将您的简历发送至用人部门,后续初筛通过,我们会联系您!!!",
  ];

  link() {
    jumpWithAnimation = (animation, nextFrame) {
      void anim() {
        if (animation) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeIn,
          );
        } else {
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      }

      if (nextFrame) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          anim();
        });
      } else {
        anim();
      }

    };
  }

  loadData() {
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   dataList.value = test.map((item) {
    //     final id = int.parse(item.substring(0,1));
    //     final text = item.substring(1,item.length - 1);
    //     return ChatItemModel(
    //       id: id,
    //       text: text,
    //     );
    //   }).toList();
    // });
  }

  addTest() {
    if (dataList.value.length == test.length) return;
    final item = test[dataList.value.length];
    final id = int.parse(item.substring(0, 1));
    final text = item.substring(1, item.length);
    final model = ChatItemModel(
      id: id,
      text: text,
    );
    dataList.value = List.from(dataList.value..add(model));
    jumpWithAnimation?.call(true,true);
  }

  send(String value) {
    test.add(value);
    addTest();
  }

  hasFocus() {

  }
}
