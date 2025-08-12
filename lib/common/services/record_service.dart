import 'dart:io';

import 'package:chat_demo/common/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordService {
  AudioRecorder? _recorder;

  Future<void> start(String path) async {
    _recorder = AudioRecorder();
    if (await _recorder!.hasPermission()) {
      await _recorder!.start(const RecordConfig(), path: path);
    }
  }

  Future<String?> stop() async {
    final path = await _recorder?.stop();
    final file = File(path!);
    if (await file.exists()) {
      llPrint("111111file: ${file.path}");
    } else {
      llPrint("11111111file not exists");
    }
    return file.path;
  }
}

class ChatRecordService {
  static Future<String> createRecordPath() async {
    final pathBase = await getApplicationSupportDirectory().then((value) => value.path);
    final path = '$pathBase/${DateTime.now().millisecondsSinceEpoch}.m4a';
    return path;
  }
}
