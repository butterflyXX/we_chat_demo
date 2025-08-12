import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_demo/common/common.dart';
import 'package:crypto/crypto.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';

class XfTtsConfig {
  final String appId;
  final String apiKey;
  final String apiSecret;
  final String host;
  final String path;

  final String vcn;
  final int speed;
  final int volume;
  final int pitch;
  final String encoding;
  final int sampleRate;

  const XfTtsConfig({
    required this.appId,
    required this.apiKey,
    required this.apiSecret,
    required this.host,
    required this.path,
    required this.vcn,
    this.speed = 50,
    this.volume = 50,
    this.pitch = 50,
    this.encoding = 'lame',
    this.sampleRate = 24000,
  });
}

class XfTtsService {
  XfTtsService(this.config);

  final XfTtsConfig config;
  late final AudioPlayer _player = AudioPlayer();

  String _buildAuthUrl() {
    final date = HttpDate.format(DateTime.now().toUtc());
    final signatureOrigin = 'host: ${config.host}\n'
        'date: $date\n'
        'GET ${config.path} HTTP/1.1';
    final hmacSha256 = Hmac(sha256, utf8.encode(config.apiSecret));
    final signature = base64.encode(hmacSha256.convert(utf8.encode(signatureOrigin)).bytes);

    final authorization = 'api_key="${config.apiKey}", algorithm="hmac-sha256", '
        'headers="host date request-line", signature="$signature"';
    final authBase64 = base64.encode(utf8.encode(authorization));

    final uri = Uri(
      scheme: 'wss',
      host: config.host,
      path: config.path,
      queryParameters: {
        'authorization': authBase64,
        'date': date,
        'host': config.host,
      },
    );
    return uri.toString();
  }

  Future<File> _createTempAudioFile() async {
    final dir = await getTemporaryDirectory();
    final ext = config.encoding == 'lame' ? 'mp3' : 'pcm';
    final file = File('${dir.path}/tts_${DateTime.now().millisecondsSinceEpoch}.$ext');
    if (await file.exists()) await file.delete();
    return file.create(recursive: true);
  }

  Future<File?> _synthesizeToFile(String text) async {
    final url = _buildAuthUrl();
    final rawSocket = await WebSocket.connect(url).timeout(const Duration(seconds: 15));
    final channel = IOWebSocketChannel(rawSocket);

    final outFile = await _createTempAudioFile();
    final sink = outFile.openWrite();

    final completer = Completer<File?>();
    late final StreamSubscription sub;

    sub = channel.stream.listen((event) async {
      try {
        llPrint("tts event: $event");
        final map = jsonDecode(event as String) as Map<String, dynamic>;
        final header = map['header'] as Map<String, dynamic>?;
        final code = header?['code'] ?? 0;
        if (code != 0) {
          llPrint("tts error: $code ${header?['message']}");
          if (!completer.isCompleted) completer.complete(null);
          return;
        }
        final payload = map['payload'] as Map<String, dynamic>?;
        final audioObj = payload?['audio'] as Map<String, dynamic>?;
        if (audioObj != null && audioObj['audio'] != null) {
          final base64Audio = audioObj['audio'] as String;
          final bytes = base64Decode(base64Audio);
          sink.add(bytes);
        }
        final status = (audioObj?['status'] ?? header?['status']) as int?;
        if (status == 2) {
          await sink.close();
          await sub.cancel();
          await channel.sink.close();
          if (!completer.isCompleted) completer.complete(outFile);
        }
      } catch (e) {
        await sink.close();
        await sub.cancel();
        await channel.sink.close();
        llPrint("tts error: $e");
        if (!completer.isCompleted) completer.complete(null);
      }
    }, onError: (e) async {
      await sink.close();
      llPrint("tts error: $e");
      if (!completer.isCompleted) completer.complete(null);
    }, onDone: () async {
      await sink.close();
      llPrint("tts done");
      if (!completer.isCompleted) completer.complete(null);
    });

    final req = {
      "header": {
        "app_id": config.appId,
        "status": 2,
      },
      "parameter": {
        "tts": {
          "vcn": config.vcn,
          "speed": config.speed,
          "volume": config.volume,
          "pitch": config.pitch,
          "bgs": 0,
          "reg": 0,
          "rdn": 0,
          "rhy": 0,
          "audio": {
            "encoding": config.encoding,
            "sample_rate": config.sampleRate,
            "channels": 1,
            "bit_depth": 16,
            "frame_size": 0
          }
        }
      },
      "payload": {
        "text": {
          "encoding": "utf8",
          "compress": "raw",
          "format": "plain",
          "status": 2,
          "seq": 0,
          "text": base64.encode(utf8.encode(text))
        }
      }
    };

    channel.sink.add(jsonEncode(req));
    return completer.future;
  }

  Future<void> speak(String text) async {
    final file = await _synthesizeToFile(text);
    if (file == null) {
      llPrint("TTS file is null");
      return;
    }
    await _player.setAudioSource(AudioSource.file(file.path));
    await _player.play();
  }

  Future<void> dispose() async {
    await _player.stop();
    await _player.dispose();
  }
}

