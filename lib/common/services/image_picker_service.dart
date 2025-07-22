import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_service.g.dart';

/// 图片选择服务
///
/// 暴露三个方法：
/// 1. [pickFromGallery]  从系统相册选择单张图片
/// 2. [pickFromCamera]   调用相机拍照并返回图片
/// 3. [pickMultiImage]   多选图片（iOS/Android）
///
/// 返回值统一为 [File] 或 [List<File>]，如果用户取消则返回 `null` 或空列表。
@Riverpod(keepAlive: true)
class ImagePickerService extends _$ImagePickerService {
  late final ImagePicker _picker;

  @override
  ImagePickerService build() {
    _picker = ImagePicker();
    return this;
  }

  /// 从系统相册选择一张图片。
  Future<File?> pickFromGallery({ImageQuality quality = ImageQuality.high}) async {
    final XFile? xfile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: quality.value,
    );
    if (xfile == null) return null; // 用户取消
    return File(xfile.path);
  }

  /// 使用相机拍照。
  Future<File?> pickFromCamera({ImageQuality quality = ImageQuality.high}) async {
    final XFile? xfile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: quality.value,
    );
    if (xfile == null) return null;
    return File(xfile.path);
  }

  /// 多选图片（仅支持 iOS/Android，Web/桌面平台会降级为单选）。
  Future<List<File>> pickMultiImage({ImageQuality quality = ImageQuality.medium}) async {
    final List<XFile> files = await _picker.pickMultiImage(
      imageQuality: quality.value,
    );
    return files.map((e) => File(e.path)).toList();
  }
}

/// 图片压缩质量枚举，image_picker 取值 0–100。
enum ImageQuality {
  low(30),
  medium(60),
  high(90);

  const ImageQuality(this.value);
  final int value;
} 