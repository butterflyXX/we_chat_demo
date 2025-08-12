import 'package:chat_demo/common/color.dart';
import 'package:chat_demo/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording_page.g.dart';

enum RecordingStateEnum { toText, recording, cancel }

@riverpod
class RecordingState extends _$RecordingState {
  final _cancelBoxKey = GlobalKey();
  final _toTextBoxKey = GlobalKey();

  @override
  RecordingStateEnum build() {
    return RecordingStateEnum.recording;
  }

  void setStateWithPositon(Offset offset) {
    llPrint("offset: $offset");
    // 检查是否在cancel上
    final cancelBox = _cancelBoxKey.currentContext?.findRenderObject() as RenderBox?;
    if (cancelBox != null) {
      final cancelBoxPosition = cancelBox.localToGlobal(Offset.zero);
      final cancelBoxSize = cancelBox.size;
      final isInCancel =
          offset.dx > cancelBoxPosition.dx &&
          offset.dx < cancelBoxPosition.dx + cancelBoxSize.width &&
          offset.dy > cancelBoxPosition.dy &&
          offset.dy < cancelBoxPosition.dy + cancelBoxSize.height;
      llPrint("isInCancel: $isInCancel");
      if (isInCancel) {
        state = RecordingStateEnum.cancel;
        return;
      }
    }
    // 检查是否在toText上
    final toTextBox = _toTextBoxKey.currentContext?.findRenderObject() as RenderBox?;
    if (toTextBox != null) {
      final toTextBoxPosition = toTextBox.localToGlobal(Offset.zero);
      final toTextBoxSize = toTextBox.size;
      final isInToTextBox =
          offset.dx > toTextBoxPosition.dx &&
          offset.dx < toTextBoxPosition.dx + toTextBoxSize.width &&
          offset.dy > toTextBoxPosition.dy &&
          offset.dy < toTextBoxPosition.dy + toTextBoxSize.height;
      if (isInToTextBox) {
        state = RecordingStateEnum.toText;
        return;
      }
    }
    state = RecordingStateEnum.recording;
  }
}

class RecordingPage extends ConsumerStatefulWidget {
  const RecordingPage({super.key});

  @override
  ConsumerState<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends ConsumerState<RecordingPage> {
  @override
  Widget build(BuildContext context) {
    // 微信录音页面仿制
    return Container(
      color: Colors.black.withAlpha(168),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(color: Colors.black.withAlpha(128), borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic, color: Colors.white, size: 60),
                  SizedBox(height: 20),
                  Text('正在录音...', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_cancelWidget(), _toTextWidget()]),
          ],
        ),
      ),
    );
  }

  Widget _cancelWidget() {
    return Consumer(
      builder: (context, ref, child) {
        final isIn = ref.watch(recordingStateProvider) == RecordingStateEnum.cancel;
        llPrint("isIn: $isIn");
        return Container(
          key: ref.watch(recordingStateProvider.notifier)._cancelBoxKey,
          width: 150,
          height: 60,
          decoration: BoxDecoration(color: isIn ? Colors.red : disableTintColor, borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text('取消', style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _toTextWidget() {
    return Consumer(
      builder: (context, ref, child) {
        final isIn = ref.watch(recordingStateProvider) == RecordingStateEnum.toText;
        llPrint("isIn: $isIn");
        return Container(
          key: ref.watch(recordingStateProvider.notifier)._toTextBoxKey,
          width: 150,
          height: 60,
          decoration: BoxDecoration(color: isIn ? Colors.green : disableTintColor, borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text('转文字', style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }
}
