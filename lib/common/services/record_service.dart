import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordService {
  AudioRecorder? _recorder;

  Future<void> start() async {
    _recorder = AudioRecorder();
    if (await _recorder!.hasPermission()) {
      final pathBase = await getTemporaryDirectory().then((value) => value.path);
      final path = '$pathBase/record.pcm';
      await _recorder!.start(const RecordConfig(), path: path);
    }
  }

  Future<String?> stop() async {
    return await _recorder?.stop();
  }
}
