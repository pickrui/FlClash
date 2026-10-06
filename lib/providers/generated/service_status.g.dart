// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../service_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServiceStatus)
final serviceStatusProvider = ServiceStatusFamily._();

final class ServiceStatusProvider
    extends $NotifierProvider<ServiceStatus, ServiceCheckState> {
  ServiceStatusProvider._({
    required ServiceStatusFamily super.from,
    required ProbeTarget super.argument,
  }) : super(
         retry: null,
         name: r'serviceStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$serviceStatusHash();

  @override
  String toString() {
    return r'serviceStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ServiceStatus create() => ServiceStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceCheckState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceCheckState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serviceStatusHash() => r'a3b769f1e19e0292bade13c408deb061366bcf9e';

final class ServiceStatusFamily extends $Family
    with
        $ClassFamilyOverride<
          ServiceStatus,
          ServiceCheckState,
          ServiceCheckState,
          ServiceCheckState,
          ProbeTarget
        > {
  ServiceStatusFamily._()
    : super(
        retry: null,
        name: r'serviceStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ServiceStatusProvider call(ProbeTarget target) =>
      ServiceStatusProvider._(argument: target, from: this);

  @override
  String toString() => r'serviceStatusProvider';
}

abstract class _$ServiceStatus extends $Notifier<ServiceCheckState> {
  late final _$args = ref.$arg as ProbeTarget;
  ProbeTarget get target => _$args;

  ServiceCheckState build(ProbeTarget target);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ServiceCheckState, ServiceCheckState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServiceCheckState, ServiceCheckState>,
              ServiceCheckState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
