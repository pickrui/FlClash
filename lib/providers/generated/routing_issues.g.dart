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

String _$routingSourceHash() => r'95c1005bb62ecb81151ef6a328c7c13e7cfe80ea';

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

@ProviderFor(routingIssues)
final routingIssuesProvider = RoutingIssuesFamily._();

final class RoutingIssuesProvider
    extends $FunctionalProvider<RoutingIssues, RoutingIssues, RoutingIssues>
    with $Provider<RoutingIssues> {
  RoutingIssuesProvider._({
    required RoutingIssuesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'routingIssuesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routingIssuesHash();

  @override
  String toString() {
    return r'routingIssuesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RoutingIssues> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RoutingIssues create(Ref ref) {
    final argument = this.argument as int;
    return routingIssues(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutingIssues value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutingIssues>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RoutingIssuesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routingIssuesHash() => r'e30f28eceb47bfb2759a8b11596ec4a5f49d8bb3';

final class RoutingIssuesFamily extends $Family
    with $FunctionalFamilyOverride<RoutingIssues, int> {
  RoutingIssuesFamily._()
    : super(
        retry: null,
        name: r'routingIssuesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutingIssuesProvider call(int profileId) =>
      RoutingIssuesProvider._(argument: profileId, from: this);

  @override
  String toString() => r'routingIssuesProvider';
}
