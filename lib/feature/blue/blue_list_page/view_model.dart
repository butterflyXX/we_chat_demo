import 'package:flutter_blue/flutter_blue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class BlueDevices extends _$BlueDevices {
  @override
  List<ScanResult> build() {
    FlutterBlue.instance.scanResults
        .map((items) {
          return items.where((item) {
            bool contains =
                item.device.name.toLowerCase().contains("leionhey2") ||
                item.device.name.toLowerCase().contains("leion hey2");
            return contains;
          }).toList();
        })
        .listen((results) {
          state = results;
        });
    return [];
  }
}
