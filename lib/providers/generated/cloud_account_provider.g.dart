// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../cloud_account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CloudAccount)
const cloudAccountProvider = CloudAccountProvider._();

final class CloudAccountProvider
    extends $NotifierProvider<CloudAccount, CloudAccountState> {
  const CloudAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudAccountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudAccountHash();

  @$internal
  @override
  CloudAccount create() => CloudAccount();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudAccountState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudAccountState>(value),
    );
  }
}

String _$cloudAccountHash() => r'f395f0128512f228fad5fe19ff6bfe53249f4dd6';

abstract class _$CloudAccount extends $Notifier<CloudAccountState> {
  CloudAccountState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CloudAccountState, CloudAccountState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CloudAccountState, CloudAccountState>,
              CloudAccountState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
