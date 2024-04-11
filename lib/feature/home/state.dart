import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_demo/feature/chat_detail/view.dart';
import 'package:we_chat_demo/model/home_item_model.dart';

class HomeState {
  BuildContext _context;
  ValueNotifier<List<HomeItemModel>> dataList = ValueNotifier([]);
  HomeState(this._context) {
    loadData();
  }

  void loadData() {
    final current = DateTime.now();

    Future.delayed(Duration(seconds: 1)).then((value) {
      dataList.value = List.generate(20, (index) {
        return HomeItemModel(
          icon: "icon",
          title: "test-$index",
          subTitle: "test-$index description sdhjsjdh1",
          id: index,
          time: current.millisecondsSinceEpoch - 1000*60*60*index,
          name: "名字 - $index",
        );
      });
    });
  }

  gotoChatDetail(HomeItemModel model) {
    Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>ChatDetailPage(model: model)));
  }
}
