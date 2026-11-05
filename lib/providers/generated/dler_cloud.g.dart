// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dler_cloud.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dler Cloud 账户 Provider

@ProviderFor(DlerCloudAccount)
const dlerCloudAccountProvider = DlerCloudAccountProvider._();

/// Dler Cloud 账户 Provider
final class DlerCloudAccountProvider
    extends $AsyncNotifierProvider<DlerCloudAccount, DlerCloudAccountState> {
  /// Dler Cloud 账户 Provider
  const DlerCloudAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dlerCloudAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dlerCloudAccountHash();

  @$internal
  @override
  DlerCloudAccount create() => DlerCloudAccount();
}

String _$dlerCloudAccountHash() => r'6c9863e41c2795bfe804befd9eff92af47cac80d';

/// Dler Cloud 账户 Provider

abstract class _$DlerCloudAccount
    extends $AsyncNotifier<DlerCloudAccountState> {
  FutureOr<DlerCloudAccountState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<DlerCloudAccountState>, DlerCloudAccountState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<DlerCloudAccountState>,
                DlerCloudAccountState
              >,
              AsyncValue<DlerCloudAccountState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
