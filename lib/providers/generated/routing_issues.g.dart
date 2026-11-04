// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../routing_issues.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routingSource)
final routingSourceProvider = RoutingSourceFamily._();

final class RoutingSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>?>,
          Map<String, dynamic>?,
          FutureOr<Map<String, dynamic>?>
        >
    with
        $FutureModifier<Map<String, dynamic>?>,
        $FutureProvider<Map<String, dynamic>?> {
  RoutingSourceProvider._({
    required RoutingSourceFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routingSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routingSourceHash();

  @override
  String toString() {
    return r'routingSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>?> create(Ref ref) {
    final argument = this.argument as int;
    return routingSource(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutingSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routingSourceHash() => r'ff33bc3b3524b1605c982a0467209ada5eb87464';

final class RoutingSourceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>?>, int> {
  RoutingSourceFamily._()
    : super(
        retry: null,
        name: r'routingSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutingSourceProvider call(int profileId) =>
      RoutingSourceProvider._(argument: profileId, from: this);

  @override
  String toString() => r'routingSourceProvider';
}

@ProviderFor(RoutingIssuesState)
final routingIssuesProvider = RoutingIssuesStateFamily._();

final class RoutingIssuesStateProvider
    extends $NotifierProvider<RoutingIssuesState, RoutingIssues> {
  RoutingIssuesStateProvider._({
    required RoutingIssuesStateFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routingIssuesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routingIssuesStateHash();

  @override
  String toString() {
    return r'routingIssuesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoutingIssuesState create() => RoutingIssuesState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutingIssues value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutingIssues>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RoutingIssuesStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routingIssuesStateHash() =>
    r'fe83f659ec0774a7023bf4b90d1f9a001c131a0c';

final class RoutingIssuesStateFamily extends $Family
    with
        $ClassFamilyOverride<
          RoutingIssuesState,
          RoutingIssues,
          RoutingIssues,
          RoutingIssues,
          int
        > {
  RoutingIssuesStateFamily._()
    : super(
        retry: null,
        name: r'routingIssuesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutingIssuesStateProvider call(int profileId) =>
      RoutingIssuesStateProvider._(argument: profileId, from: this);

  @override
  String toString() => r'routingIssuesProvider';
}

abstract class _$RoutingIssuesState extends $Notifier<RoutingIssues> {
  late final _$args = ref.$arg as int;
  int get profileId => _$args;

  RoutingIssues build(int profileId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RoutingIssues, RoutingIssues>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RoutingIssues, RoutingIssues>,
              RoutingIssues,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
