// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../icon_sets.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IconSets)
final iconSetsProvider = IconSetsProvider._();

final class IconSetsProvider
    extends $StreamNotifierProvider<IconSets, List<IconSet>> {
  IconSetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iconSetsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iconSetsHash();

  @$internal
  @override
  IconSets create() => IconSets();
}

String _$iconSetsHash() => r'49cba315d0e98fd6f825b8223e98515a189a4472';

abstract class _$IconSets extends $StreamNotifier<List<IconSet>> {
  Stream<List<IconSet>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<IconSet>>, List<IconSet>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<IconSet>>, List<IconSet>>,
              AsyncValue<List<IconSet>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IconSetsAction)
final iconSetsActionProvider = IconSetsActionProvider._();

final class IconSetsActionProvider
    extends $NotifierProvider<IconSetsAction, void> {
  IconSetsActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iconSetsActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iconSetsActionHash();

  @$internal
  @override
  IconSetsAction create() => IconSetsAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$iconSetsActionHash() => r'e4f251d4b6a4b18e8bb3959c87d42694e41d3ba5';

abstract class _$IconSetsAction extends $Notifier<void> {
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
