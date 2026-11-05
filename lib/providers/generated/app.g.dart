// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../app.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RealTunEnable)
final realTunEnableProvider = RealTunEnableProvider._();

final class RealTunEnableProvider
    extends $NotifierProvider<RealTunEnable, bool> {
  RealTunEnableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'realTunEnableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$realTunEnableHash();

  @$internal
  @override
  RealTunEnable create() => RealTunEnable();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$realTunEnableHash() => r'44965c8f4816f7525896dc659a4043860dea1436';

abstract class _$RealTunEnable extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Logs)
final logsProvider = LogsProvider._();

final class LogsProvider extends $NotifierProvider<Logs, FixedList<Log>> {
  LogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logsHash();

  @$internal
  @override
  Logs create() => Logs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FixedList<Log> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FixedList<Log>>(value),
    );
  }
}

String _$logsHash() => r'9a103f2c0b57086e2249d50257eaf70218dbd9a2';

abstract class _$Logs extends $Notifier<FixedList<Log>> {
  FixedList<Log> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FixedList<Log>, FixedList<Log>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FixedList<Log>, FixedList<Log>>,
              FixedList<Log>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Requests)
final requestsProvider = RequestsProvider._();

final class RequestsProvider
    extends $NotifierProvider<Requests, FixedList<TrackerInfo>> {
  RequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestsHash();

  @$internal
  @override
  Requests create() => Requests();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FixedList<TrackerInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FixedList<TrackerInfo>>(value),
    );
  }
}

String _$requestsHash() => r'56c9be1d453a88d78ff2fe8ebf519cc75fa77149';

abstract class _$Requests extends $Notifier<FixedList<TrackerInfo>> {
  FixedList<TrackerInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<FixedList<TrackerInfo>, FixedList<TrackerInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FixedList<TrackerInfo>, FixedList<TrackerInfo>>,
              FixedList<TrackerInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Providers)
final providersProvider = ProvidersProvider._();

final class ProvidersProvider
    extends $NotifierProvider<Providers, List<ExternalProvider>> {
  ProvidersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providersHash();

  @$internal
  @override
  Providers create() => Providers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ExternalProvider> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ExternalProvider>>(value),
    );
  }
}

String _$providersHash() => r'710d08d14fcb3bcfd2ce066b61a8b960a61a6ceb';

abstract class _$Providers extends $Notifier<List<ExternalProvider>> {
  List<ExternalProvider> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<ExternalProvider>, List<ExternalProvider>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ExternalProvider>, List<ExternalProvider>>,
              List<ExternalProvider>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Packages)
final packagesProvider = PackagesProvider._();

final class PackagesProvider
    extends $NotifierProvider<Packages, List<Package>> {
  PackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packagesHash();

  @$internal
  @override
  Packages create() => Packages();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Package> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Package>>(value),
    );
  }
}

String _$packagesHash() => r'edcd682f727fd93673c54f53cda7dbe24f5ff92d';

abstract class _$Packages extends $Notifier<List<Package>> {
  List<Package> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Package>, List<Package>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Package>, List<Package>>,
              List<Package>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SystemBrightness)
final systemBrightnessProvider = SystemBrightnessProvider._();

final class SystemBrightnessProvider
    extends $NotifierProvider<SystemBrightness, Brightness> {
  SystemBrightnessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemBrightnessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemBrightnessHash();

  @$internal
  @override
  SystemBrightness create() => SystemBrightness();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Brightness>(value),
    );
  }
}

String _$systemBrightnessHash() => r'47c75d241e33949655873bbdb711cb3dd11d6adc';

abstract class _$SystemBrightness extends $Notifier<Brightness> {
  Brightness build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Brightness, Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Brightness, Brightness>,
              Brightness,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Traffics)
final trafficsProvider = TrafficsProvider._();

final class TrafficsProvider
    extends $NotifierProvider<Traffics, FixedList<Traffic>> {
  TrafficsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trafficsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trafficsHash();

  @$internal
  @override
  Traffics create() => Traffics();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FixedList<Traffic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FixedList<Traffic>>(value),
    );
  }
}

String _$trafficsHash() => r'52f4905d8917d545c55292824a90248aaf4ce0e4';

abstract class _$Traffics extends $Notifier<FixedList<Traffic>> {
  FixedList<Traffic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FixedList<Traffic>, FixedList<Traffic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FixedList<Traffic>, FixedList<Traffic>>,
              FixedList<Traffic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TotalTraffic)
final totalTrafficProvider = TotalTrafficProvider._();

final class TotalTrafficProvider
    extends $NotifierProvider<TotalTraffic, Traffic> {
  TotalTrafficProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalTrafficProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalTrafficHash();

  @$internal
  @override
  TotalTraffic create() => TotalTraffic();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Traffic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Traffic>(value),
    );
  }
}

String _$totalTrafficHash() => r'358413d1830038ac65cc7a1552867adf7dfdcfa6';

abstract class _$TotalTraffic extends $Notifier<Traffic> {
  Traffic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Traffic, Traffic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Traffic, Traffic>,
              Traffic,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LocalIp)
final localIpProvider = LocalIpProvider._();

final class LocalIpProvider extends $NotifierProvider<LocalIp, String?> {
  LocalIpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localIpProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localIpHash();

  @$internal
  @override
  LocalIp create() => LocalIp();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$localIpHash() => r'4deab0271c820bd1a4729f3631270038f92e5fd8';

abstract class _$LocalIp extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RunTime)
final runTimeProvider = RunTimeProvider._();

final class RunTimeProvider extends $NotifierProvider<RunTime, int?> {
  RunTimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runTimeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runTimeHash();

  @$internal
  @override
  RunTime create() => RunTime();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$runTimeHash() => r'8b7c5ab07279ac562f598bad36c2a1285cb9d57b';

abstract class _$RunTime extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ViewSize)
final viewSizeProvider = ViewSizeProvider._();

final class ViewSizeProvider extends $NotifierProvider<ViewSize, Size> {
  ViewSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewSizeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewSizeHash();

  @$internal
  @override
  ViewSize create() => ViewSize();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Size value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Size>(value),
    );
  }
}

String _$viewSizeHash() => r'4fa8be8722071b345a61e7bbd5f20a71e3583e7c';

abstract class _$ViewSize extends $Notifier<Size> {
  Size build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Size, Size>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Size, Size>,
              Size,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SideWidth)
final sideWidthProvider = SideWidthProvider._();

final class SideWidthProvider extends $NotifierProvider<SideWidth, double> {
  SideWidthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sideWidthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sideWidthHash();

  @$internal
  @override
  SideWidth create() => SideWidth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$sideWidthHash() => r'b6ba49ebae956b4f34f877058f455a073583fb0a';

abstract class _$SideWidth extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(viewWidth)
final viewWidthProvider = ViewWidthProvider._();

final class ViewWidthProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  ViewWidthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewWidthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewWidthHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return viewWidth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$viewWidthHash() => r'5ee8f1bdebe44760f7333f88127108f5ffd70214';

@ProviderFor(viewMode)
final viewModeProvider = ViewModeProvider._();

final class ViewModeProvider
    extends $FunctionalProvider<ViewMode, ViewMode, ViewMode>
    with $Provider<ViewMode> {
  ViewModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewModeHash();

  @$internal
  @override
  $ProviderElement<ViewMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ViewMode create(Ref ref) {
    return viewMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ViewMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ViewMode>(value),
    );
  }
}

String _$viewModeHash() => r'6822e9dc28c813afe1ed743feea464f0d33c805c';

@ProviderFor(isMobileView)
final isMobileViewProvider = IsMobileViewProvider._();

final class IsMobileViewProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsMobileViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isMobileViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isMobileViewHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isMobileView(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isMobileViewHash() => r'1d75bccb4f50ae206bf43b68df869a5d95e5ea5f';

@ProviderFor(viewHeight)
final viewHeightProvider = ViewHeightProvider._();

final class ViewHeightProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  ViewHeightProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewHeightProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewHeightHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return viewHeight(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$viewHeightHash() => r'dc3fc18337b5ce9fc953d994c380e8f1fa49f352';

@ProviderFor(Init)
final initProvider = InitProvider._();

final class InitProvider extends $NotifierProvider<Init, bool> {
  InitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initHash();

  @$internal
  @override
  Init create() => Init();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$initHash() => r'3a6ef19fa2571f61626b135889d60f27188fec2c';

abstract class _$Init extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentPageLabel)
final currentPageLabelProvider = CurrentPageLabelProvider._();

final class CurrentPageLabelProvider
    extends $NotifierProvider<CurrentPageLabel, PageLabel> {
  CurrentPageLabelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPageLabelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPageLabelHash();

  @$internal
  @override
  CurrentPageLabel create() => CurrentPageLabel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PageLabel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PageLabel>(value),
    );
  }
}

String _$currentPageLabelHash() => r'557a1349f76b8d055dbb2c50ed22048b7bebf368';

abstract class _$CurrentPageLabel extends $Notifier<PageLabel> {
  PageLabel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PageLabel, PageLabel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PageLabel, PageLabel>,
              PageLabel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SortNum)
final sortNumProvider = SortNumProvider._();

final class SortNumProvider extends $NotifierProvider<SortNum, int> {
  SortNumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortNumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortNumHash();

  @$internal
  @override
  SortNum create() => SortNum();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$sortNumHash() => r'cd3e80451b08861e5cd8a4fd876d4f1f04b5b067';

abstract class _$SortNum extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CheckIpNum)
final checkIpNumProvider = CheckIpNumProvider._();

final class CheckIpNumProvider extends $NotifierProvider<CheckIpNum, int> {
  CheckIpNumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkIpNumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkIpNumHash();

  @$internal
  @override
  CheckIpNum create() => CheckIpNum();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$checkIpNumHash() => r'cb31d1c1f6621770443b6dc61fabe80ea1e2fdfd';

abstract class _$CheckIpNum extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(BackBlock)
final backBlockProvider = BackBlockProvider._();

final class BackBlockProvider extends $NotifierProvider<BackBlock, bool> {
  BackBlockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backBlockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backBlockHash();

  @$internal
  @override
  BackBlock create() => BackBlock();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$backBlockHash() => r'21f1de335a399e6aae3993e21f578c0b8b7ad192';

abstract class _$BackBlock extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Version)
final versionProvider = VersionProvider._();

final class VersionProvider extends $NotifierProvider<Version, int> {
  VersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'versionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$versionHash();

  @$internal
  @override
  Version create() => Version();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$versionHash() => r'ca3bf4dd4e025b6deaf3fd2a0de81e78f7d41dba';

abstract class _$Version extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Groups)
final groupsProvider = GroupsProvider._();

final class GroupsProvider extends $NotifierProvider<Groups, List<Group>> {
  GroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupsHash();

  @$internal
  @override
  Groups create() => Groups();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Group> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Group>>(value),
    );
  }
}

String _$groupsHash() => r'5f5178ab34a169e06cc5570c8ac2866e2d89f6a5';

abstract class _$Groups extends $Notifier<List<Group>> {
  List<Group> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Group>, List<Group>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Group>, List<Group>>,
              List<Group>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(DelayDataSource)
final delayDataSourceProvider = DelayDataSourceProvider._();

final class DelayDataSourceProvider
    extends $NotifierProvider<DelayDataSource, DelayMap> {
  DelayDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'delayDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$delayDataSourceHash();

  @$internal
  @override
  DelayDataSource create() => DelayDataSource();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DelayMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DelayMap>(value),
    );
  }
}

String _$delayDataSourceHash() => r'95166be8367148496b833669fcb51238c679bcd5';

abstract class _$DelayDataSource extends $Notifier<DelayMap> {
  DelayMap build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DelayMap, DelayMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DelayMap, DelayMap>,
              DelayMap,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SystemUiOverlayStyleState)
final systemUiOverlayStyleStateProvider = SystemUiOverlayStyleStateProvider._();

final class SystemUiOverlayStyleStateProvider
    extends $NotifierProvider<SystemUiOverlayStyleState, SystemUiOverlayStyle> {
  SystemUiOverlayStyleStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemUiOverlayStyleStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemUiOverlayStyleStateHash();

  @$internal
  @override
  SystemUiOverlayStyleState create() => SystemUiOverlayStyleState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemUiOverlayStyle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemUiOverlayStyle>(value),
    );
  }
}

String _$systemUiOverlayStyleStateHash() =>
    r'4d164a39c08b5435821a6dacdd70782a4be9d239';

abstract class _$SystemUiOverlayStyleState
    extends $Notifier<SystemUiOverlayStyle> {
  SystemUiOverlayStyle build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SystemUiOverlayStyle, SystemUiOverlayStyle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SystemUiOverlayStyle, SystemUiOverlayStyle>,
              SystemUiOverlayStyle,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(_CoreStatus)
final coreStatusProvider = _CoreStatusProvider._();

final class _CoreStatusProvider
    extends $NotifierProvider<_CoreStatus, CoreStatus> {
  _CoreStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coreStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_coreStatusHash();

  @$internal
  @override
  _CoreStatus create() => _CoreStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoreStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoreStatus>(value),
    );
  }
}

String _$_coreStatusHash() => r'a6ecfd4d3c85fabaa75a8d97a75791e886906ab6';

abstract class _$CoreStatus extends $Notifier<CoreStatus> {
  CoreStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CoreStatus, CoreStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CoreStatus, CoreStatus>,
              CoreStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Query)
final queryProvider = QueryFamily._();

final class QueryProvider extends $NotifierProvider<Query, String> {
  QueryProvider._({
    required QueryFamily super.from,
    required QueryTag super.argument,
  }) : super(
         retry: null,
         name: r'queryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$queryHash();

  @override
  String toString() {
    return r'queryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Query create() => Query();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QueryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$queryHash() => r'23fcea2809f9a2d3d3ab740d9e51419b00d1c428';

final class QueryFamily extends $Family
    with $ClassFamilyOverride<Query, String, String, String, QueryTag> {
  QueryFamily._()
    : super(
        retry: null,
        name: r'queryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QueryProvider call(QueryTag tag) =>
      QueryProvider._(argument: tag, from: this);

  @override
  String toString() => r'queryProvider';
}

abstract class _$Query extends $Notifier<String> {
  late final _$args = ref.$arg as QueryTag;
  QueryTag get tag => _$args;

  String build(QueryTag tag);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(Loading)
final loadingProvider = LoadingFamily._();

final class LoadingProvider extends $NotifierProvider<Loading, bool> {
  LoadingProvider._({
    required LoadingFamily super.from,
    required LoadingTag super.argument,
  }) : super(
         retry: null,
         name: r'loadingProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loadingHash();

  @override
  String toString() {
    return r'loadingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Loading create() => Loading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LoadingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loadingHash() => r'e2f7783de8bb780cfa75f949ac6e6e901d32b901';

final class LoadingFamily extends $Family
    with $ClassFamilyOverride<Loading, bool, bool, bool, LoadingTag> {
  LoadingFamily._()
    : super(
        retry: null,
        name: r'loadingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  LoadingProvider call(LoadingTag tag) =>
      LoadingProvider._(argument: tag, from: this);

  @override
  String toString() => r'loadingProvider';
}

abstract class _$Loading extends $Notifier<bool> {
  late final _$args = ref.$arg as LoadingTag;
  LoadingTag get tag => _$args;

  bool build(LoadingTag tag);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SelectedItems)
final selectedItemsProvider = SelectedItemsFamily._();

final class SelectedItemsProvider
    extends $NotifierProvider<SelectedItems, Set<dynamic>> {
  SelectedItemsProvider._({
    required SelectedItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedItemsHash();

  @override
  String toString() {
    return r'selectedItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedItems create() => SelectedItems();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<dynamic>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedItemsHash() => r'c85929f9d99599cc179fff6b87a4201615a6bfdb';

final class SelectedItemsFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedItems,
          Set<dynamic>,
          Set<dynamic>,
          Set<dynamic>,
          String
        > {
  SelectedItemsFamily._()
    : super(
        retry: null,
        name: r'selectedItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedItemsProvider call(String key) =>
      SelectedItemsProvider._(argument: key, from: this);

  @override
  String toString() => r'selectedItemsProvider';
}

abstract class _$SelectedItems extends $Notifier<Set<dynamic>> {
  late final _$args = ref.$arg as String;
  String get key => _$args;

  Set<dynamic> build(String key);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<dynamic>, Set<dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<dynamic>, Set<dynamic>>,
              Set<dynamic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SelectedItem)
final selectedItemProvider = SelectedItemFamily._();

final class SelectedItemProvider
    extends $NotifierProvider<SelectedItem, dynamic> {
  SelectedItemProvider._({
    required SelectedItemFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'selectedItemProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedItemHash();

  @override
  String toString() {
    return r'selectedItemProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedItem create() => SelectedItem();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedItemProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedItemHash() => r'd36f1397b203db871f5d552031285e23748911f9';

final class SelectedItemFamily extends $Family
    with $ClassFamilyOverride<SelectedItem, dynamic, dynamic, dynamic, String> {
  SelectedItemFamily._()
    : super(
        retry: null,
        name: r'selectedItemProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedItemProvider call(String key) =>
      SelectedItemProvider._(argument: key, from: this);

  @override
  String toString() => r'selectedItemProvider';
}

abstract class _$SelectedItem extends $Notifier<dynamic> {
  late final _$args = ref.$arg as String;
  String get key => _$args;

  dynamic build(String key);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<dynamic, dynamic>,
              dynamic,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(IsUpdating)
final isUpdatingProvider = IsUpdatingFamily._();

final class IsUpdatingProvider extends $NotifierProvider<IsUpdating, bool> {
  IsUpdatingProvider._({
    required IsUpdatingFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isUpdatingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isUpdatingHash();

  @override
  String toString() {
    return r'isUpdatingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsUpdating create() => IsUpdating();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsUpdatingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isUpdatingHash() => r'e48bf1a00f8ac22a905fc56eea278468af3971d4';

final class IsUpdatingFamily extends $Family
    with $ClassFamilyOverride<IsUpdating, bool, bool, bool, String> {
  IsUpdatingFamily._()
    : super(
        retry: null,
        name: r'isUpdatingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsUpdatingProvider call(String name) =>
      IsUpdatingProvider._(argument: name, from: this);

  @override
  String toString() => r'isUpdatingProvider';
}

abstract class _$IsUpdating extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get name => _$args;

  bool build(String name);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(NetworkDetection)
final networkDetectionProvider = NetworkDetectionProvider._();

final class NetworkDetectionProvider
    extends $NotifierProvider<NetworkDetection, NetworkDetectionState> {
  NetworkDetectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkDetectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkDetectionHash();

  @$internal
  @override
  NetworkDetection create() => NetworkDetection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkDetectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkDetectionState>(value),
    );
  }
}

String _$networkDetectionHash() => r'5e1de6a5d5835c6cf70aa9734ae8099787cd41bc';

abstract class _$NetworkDetection extends $Notifier<NetworkDetectionState> {
  NetworkDetectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NetworkDetectionState, NetworkDetectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NetworkDetectionState, NetworkDetectionState>,
              NetworkDetectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
