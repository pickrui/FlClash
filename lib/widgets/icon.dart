import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';

class CommonTargetIcon extends StatelessWidget {
  final String src;
  final double size;

  const CommonTargetIcon({super.key, required this.src, required this.size});

  Widget _defaultIcon() {
    return Icon(IconsExt.target, size: size);
  }

  Widget _buildIcon() {
    if (src.isEmpty) {
      return _defaultIcon();
    }

    final base64 = src.getBase64;
    if (base64 != null) {
      return Image.memory(
        base64,
        gaplessPlayback: true,
        errorBuilder: (_, error, _) {
          return _defaultIcon();
        },
      );
    }

    return ImageCacheWidget(src: src, defaultWidget: _defaultIcon());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: _buildIcon());
  }
}

final _cacheMange = DefaultCacheManager();

class ImageCacheWidget extends StatefulWidget {
  final String src;
  final Widget defaultWidget;

  const ImageCacheWidget({
    super.key,
    required this.src,
    required this.defaultWidget,
  });

  @override
  State<ImageCacheWidget> createState() => _ImageCacheWidgetState();
}

class _ImageCacheWidgetState extends State<ImageCacheWidget> {
  final ValueNotifier<File?> _imageNotifier = ValueNotifier(null);
  int _retryCount = 0;

  @override
  void initState() {
    super.initState();
    _getImageFormCache();
  }

  void _getImageFormCache() async {
    final src = widget.src;
    final cacheFile = await _cacheMange.getFileFromCache(src);
    if (!mounted) {
      return;
    }
    if (cacheFile != null) {
      _imageNotifier.value = cacheFile.file;
      if (cacheFile.validTill.isAfter(DateTime.now())) {
        return;
      }
    }
    if (!mounted) {
      return;
    }
    try {
      final file = (await _cacheMange.downloadFile(src, key: src)).file;
      if (!mounted) {
        return;
      }
      _retryCount = 0;
      _imageNotifier.value = file;
    } catch (_) {
      // Keep the stale cached image (or default icon) when refresh fails.
      if (!mounted || _imageNotifier.value != null || _retryCount >= 2) {
        return;
      }
      _retryCount++;
      await Future.delayed(Duration(seconds: 2 * _retryCount));
      if (!mounted) {
        return;
      }
      _getImageFormCache();
    }
  }

  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: _imageNotifier,
      builder: (_, data, _) {
        if (data == null) {
          return widget.defaultWidget;
        }
        return widget.src.isSvg
            ? SvgPicture.file(
                data,
                errorBuilder: (_, _, _) => widget.defaultWidget,
              )
            : Image.file(data, errorBuilder: (_, _, _) => widget.defaultWidget);
      },
    );
  }
}
