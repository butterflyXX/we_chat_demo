// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picker_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imagePickerServiceHash() =>
    r'5e997a903fb4acfd910fae898348aeaee922e09d';

/// 图片选择服务
///
/// 暴露三个方法：
/// 1. [pickFromGallery]  从系统相册选择单张图片
/// 2. [pickFromCamera]   调用相机拍照并返回图片
/// 3. [pickMultiImage]   多选图片（iOS/Android）
///
/// 返回值统一为 [File] 或 [List<File>]，如果用户取消则返回 `null` 或空列表。
///
/// Copied from [ImagePickerService].
@ProviderFor(ImagePickerService)
final imagePickerServiceProvider =
    NotifierProvider<ImagePickerService, ImagePickerService>.internal(
      ImagePickerService.new,
      name: r'imagePickerServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imagePickerServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImagePickerService = Notifier<ImagePickerService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
