// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../mitm_modules.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mitmModuleRequest)
final mitmModuleRequestProvider = MitmModuleRequestProvider._();

final class MitmModuleRequestProvider
    extends $FunctionalProvider<Request, Request, Request>
    with $Provider<Request> {
  MitmModuleRequestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mitmModuleRequestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mitmModuleRequestHash();

  @$internal
  @override
  $ProviderElement<Request> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Request create(Ref ref) {
    return mitmModuleRequest(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Request value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Request>(value),
    );
  }
}

String _$mitmModuleRequestHash() => r'3bf06043008d96dee723f1282010abfdeff8c517';

@ProviderFor(MitmModulesAction)
final mitmModulesActionProvider = MitmModulesActionProvider._();

final class MitmModulesActionProvider
    extends $NotifierProvider<MitmModulesAction, void> {
  MitmModulesActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mitmModulesActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mitmModulesActionHash();

  @$internal
  @override
  MitmModulesAction create() => MitmModulesAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$mitmModulesActionHash() => r'f7f33c914adf3b7af5fb2e4cfdf9aa58525c5f34';

abstract class _$MitmModulesAction extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
