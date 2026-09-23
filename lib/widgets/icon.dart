import 'dart:async';
import 'dart:io';

import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/common/encoded_icon_cache.dart';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_clash/common/icon_file_service.dart';

final _decodedIcons = _IconCache();
final _recordedIconUrls = <String>{};

class _IconCache extends EncodedIconCache with WidgetsBindingObserver {
  _IconCache() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didHaveMemoryPressure() => clear();
}

ImageProvider _resizeIcon(
  ImageProvider provider,
  BuildContext context,
  double size,
) {
  final pixels = (size * MediaQuery.devicePixelRatioOf(context)).ceil().clamp(
    1,
    1024,
  );
  return ResizeImage(
    provider,
    width: pixels,
    height: pixels,
    policy: ResizeImagePolicy.fit,
  );
}

class CommonTargetIcon extends StatelessWidget {
  final String src;
  final double size;
  final bool recordHistory;

  const CommonTargetIcon({
    super.key,
    required this.src,
    required this.size,
    this.recordHistory = true,
  });

  Widget _defaultIcon() {
    return Icon(IconsExt.target, size: size);
  }

  Widget _buildIcon(BuildContext context) {
    if (src.isEmpty) {
      return _defaultIcon();
    }

    final base64 = _decodedIcons.decode(src);
    if (base64 != null) {
      return Image(
        image: _resizeIcon(MemoryImage(base64), context, size),
        gaplessPlayback: true,
        errorBuilder: (_, error, _) {
          return _defaultIcon();
        },
      );
    }

    return ImageCacheWidget(
      src: src,
      size: size,
      defaultWidget: _defaultIcon(),
      recordHistory: recordHistory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: _buildIcon(context));
  }
}

final _cacheMange = CacheManager(
  Config(DefaultCacheManager.key, fileService: IconFileService()),
);

class ImageCacheWidget extends StatefulWidget {
  final String src;
  final double size;
  final Widget defaultWidget;
  final bool recordHistory;

  const ImageCacheWidget({
    super.key,
    required this.src,
    required this.defaultWidget,
    required this.size,
    this.recordHistory = true,
  });

  @override
  State<ImageCacheWidget> createState() => _ImageCacheWidgetState();
}

class _ImageCacheWidgetState extends State<ImageCacheWidget> {
  final ValueNotifier<File?> _imageNotifier = ValueNotifier(null);
  int _retryCount = 0;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _getImageFormCache();
  }

  @override
  void didUpdateWidget(covariant ImageCacheWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      _generation++;
      _retryCount = 0;
      _imageNotifier.value = null;
      _getImageFormCache();
    }
  }

  void _getImageFormCache() async {
    final src = widget.src;
    final generation = _generation;
    bool current() => mounted && generation == _generation;
    try {
      final cacheFile = await _cacheMange.getFileFromCache(src);
      if (!current()) return;
      if (cacheFile != null) {
        _imageNotifier.value = cacheFile.file;
        _rememberIcon(src);
        if (cacheFile.validTill.isAfter(DateTime.now())) return;
      }
      final file = (await _cacheMange.downloadFile(src, key: src)).file;
      if (!current()) return;
      _retryCount = 0;
      _imageNotifier.value = file;
      _rememberIcon(src);
    } catch (_) {
      if (!current() || _imageNotifier.value != null || _retryCount >= 2) {
        return;
      }
      _retryCount++;
      await Future<void>.delayed(Duration(seconds: 2 * _retryCount));
      if (current()) _getImageFormCache();
    }
  }

  void _rememberIcon(String src) {
    if (!widget.recordHistory || !_recordedIconUrls.add(src)) return;
    unawaited(
      database.iconRecordsDao.put(src).catchError((Object error) {
        // History is optional; a storage error must not hide a downloaded icon.
        _recordedIconUrls.remove(src);
        commonPrint.log('Icon history update failed (${error.runtimeType})');
      }),
    );
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
        return isSvgIconUrl(widget.src)
            ? SvgPicture.file(
                data,
                errorBuilder: (_, _, _) => widget.defaultWidget,
              )
            : Image(
                image: _resizeIcon(FileImage(data), context, widget.size),
                errorBuilder: (_, _, _) => widget.defaultWidget,
              );
      },
    );
  }
}

class PackageIcon extends StatefulWidget {
  final String packageName;
  final double size;

  const PackageIcon({super.key, required this.packageName, required this.size});

  @override
  State<PackageIcon> createState() => _PackageIconState();
}

class _PackageIconState extends State<PackageIcon> {
  StreamSubscription<void>? _iconChanges;
  ImageProvider? _icon;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _iconChanges = app?.iconChanges.listen((_) {
      if (mounted) setState(_loadIcon);
    });
    _loadIcon();
  }

  @override
  void dispose() {
    _iconChanges?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PackageIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.packageName != widget.packageName) {
      _loadIcon();
    }
  }

  void _loadIcon() {
    final generation = ++_generation;
    final packageName = widget.packageName;
    final currentApp = app;
    if (currentApp == null || packageName.isEmpty) {
      _icon = null;
      return;
    }
    if (currentApp.hasPackageIcon(packageName)) {
      _icon = currentApp.getCachedPackageIcon(packageName);
      return;
    }
    _icon = null;
    currentApp.getPackageIcon(packageName).then((icon) {
      if (!mounted || generation != _generation || icon == null) {
        return;
      }
      setState(() {
        _icon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final icon = _icon;
    if (icon == null) {
      return SizedBox(width: widget.size, height: widget.size);
    }
    return Image(
      image: icon,
      gaplessPlayback: true,
      width: widget.size,
      height: widget.size,
    );
  }
}
