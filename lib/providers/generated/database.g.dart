// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomProxies)
final customProxiesProvider = CustomProxiesProvider._();

final class CustomProxiesProvider
    extends $StreamNotifierProvider<CustomProxies, List<ProfileProxy>> {
  CustomProxiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customProxiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customProxiesHash();

  @$internal
  @override
  CustomProxies create() => CustomProxies();
}

String _$customProxiesHash() => r'b6c4c76de70de38b67ffbddf1c84d4146129df49';

abstract class _$CustomProxies extends $StreamNotifier<List<ProfileProxy>> {
  Stream<List<ProfileProxy>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProfileProxy>>, List<ProfileProxy>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProfileProxy>>, List<ProfileProxy>>,
              AsyncValue<List<ProfileProxy>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(profilesStream)
final profilesStreamProvider = ProfilesStreamProvider._();

final class ProfilesStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Profile>>,
          List<Profile>,
          Stream<List<Profile>>
        >
    with $FutureModifier<List<Profile>>, $StreamProvider<List<Profile>> {
  ProfilesStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Profile>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Profile>> create(Ref ref) {
    return profilesStream(ref);
  }
}

String _$profilesStreamHash() => r'483907aa6c324209b5202369300a4a53230f83db';

@ProviderFor(addedRuleStream)
final addedRuleStreamProvider = AddedRuleStreamFamily._();

final class AddedRuleStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Rule>>,
          List<Rule>,
          Stream<List<Rule>>
        >
    with $FutureModifier<List<Rule>>, $StreamProvider<List<Rule>> {
  AddedRuleStreamProvider._({
    required AddedRuleStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'addedRuleStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$addedRuleStreamHash();

  @override
  String toString() {
    return r'addedRuleStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Rule>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Rule>> create(Ref ref) {
    final argument = this.argument as int;
    return addedRuleStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AddedRuleStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$addedRuleStreamHash() => r'491968ce795e56d4516a95676fcf46d575b3495f';

final class AddedRuleStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Rule>>, int> {
  AddedRuleStreamFamily._()
    : super(
        retry: null,
        name: r'addedRuleStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AddedRuleStreamProvider call(int profileId) =>
      AddedRuleStreamProvider._(argument: profileId, from: this);

  @override
  String toString() => r'addedRuleStreamProvider';
}

@ProviderFor(Profiles)
final profilesProvider = ProfilesProvider._();

final class ProfilesProvider
    extends $NotifierProvider<Profiles, List<Profile>> {
  ProfilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilesHash();

  @$internal
  @override
  Profiles create() => Profiles();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Profile> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Profile>>(value),
    );
  }
}

String _$profilesHash() => r'5865c065966215e5348f0c890f2aa996e7893f8d';

abstract class _$Profiles extends $Notifier<List<Profile>> {
  List<Profile> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Profile>, List<Profile>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Profile>, List<Profile>>,
              List<Profile>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(Scripts)
final scriptsProvider = ScriptsProvider._();

final class ScriptsProvider
    extends $StreamNotifierProvider<Scripts, List<Script>> {
  ScriptsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scriptsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scriptsHash();

  @$internal
  @override
  Scripts create() => Scripts();
}

String _$scriptsHash() => r'f24c859f4fcd2c01367c0ce428716fbdf4afc56b';

abstract class _$Scripts extends $StreamNotifier<List<Script>> {
  Stream<List<Script>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Script>>, List<Script>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Script>>, List<Script>>,
              AsyncValue<List<Script>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(MitmModules)
final mitmModulesProvider = MitmModulesProvider._();

final class MitmModulesProvider
    extends $StreamNotifierProvider<MitmModules, List<MitmModule>> {
  MitmModulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mitmModulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mitmModulesHash();

  @$internal
  @override
  MitmModules create() => MitmModules();
}

String _$mitmModulesHash() => r'48ab463b3aa917fb37f3c965c1df88a35beef9fd';

abstract class _$MitmModules extends $StreamNotifier<List<MitmModule>> {
  Stream<List<MitmModule>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MitmModule>>, List<MitmModule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MitmModule>>, List<MitmModule>>,
              AsyncValue<List<MitmModule>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(GlobalRules)
final globalRulesProvider = GlobalRulesProvider._();

final class GlobalRulesProvider
    extends $StreamNotifierProvider<GlobalRules, List<Rule>> {
  GlobalRulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalRulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalRulesHash();

  @$internal
  @override
  GlobalRules create() => GlobalRules();
}

String _$globalRulesHash() => r'63051370e304897313de9b53e994845f03a1c14c';

abstract class _$GlobalRules extends $StreamNotifier<List<Rule>> {
  Stream<List<Rule>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Rule>>, List<Rule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Rule>>, List<Rule>>,
              AsyncValue<List<Rule>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ProfileAddedRules)
final profileAddedRulesProvider = ProfileAddedRulesFamily._();

final class ProfileAddedRulesProvider
    extends $StreamNotifierProvider<ProfileAddedRules, List<Rule>> {
  ProfileAddedRulesProvider._({
    required ProfileAddedRulesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'profileAddedRulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileAddedRulesHash();

  @override
  String toString() {
    return r'profileAddedRulesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProfileAddedRules create() => ProfileAddedRules();

  @override
  bool operator ==(Object other) {
    return other is ProfileAddedRulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileAddedRulesHash() => r'0f48fb2d3baed8ded0b04b4034b381e777b2a845';

final class ProfileAddedRulesFamily extends $Family
    with
        $ClassFamilyOverride<
          ProfileAddedRules,
          AsyncValue<List<Rule>>,
          List<Rule>,
          Stream<List<Rule>>,
          int
        > {
  ProfileAddedRulesFamily._()
    : super(
        retry: null,
        name: r'profileAddedRulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileAddedRulesProvider call(int profileId) =>
      ProfileAddedRulesProvider._(argument: profileId, from: this);

  @override
  String toString() => r'profileAddedRulesProvider';
}

abstract class _$ProfileAddedRules extends $StreamNotifier<List<Rule>> {
  late final _$args = ref.$arg as int;
  int get profileId => _$args;

  Stream<List<Rule>> build(int profileId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Rule>>, List<Rule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Rule>>, List<Rule>>,
              AsyncValue<List<Rule>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ProfileDisabledRuleIds)
final profileDisabledRuleIdsProvider = ProfileDisabledRuleIdsFamily._();

final class ProfileDisabledRuleIdsProvider
    extends $StreamNotifierProvider<ProfileDisabledRuleIds, List<int>> {
  ProfileDisabledRuleIdsProvider._({
    required ProfileDisabledRuleIdsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'profileDisabledRuleIdsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileDisabledRuleIdsHash();

  @override
  String toString() {
    return r'profileDisabledRuleIdsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProfileDisabledRuleIds create() => ProfileDisabledRuleIds();

  @override
  bool operator ==(Object other) {
    return other is ProfileDisabledRuleIdsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileDisabledRuleIdsHash() =>
    r'fed8c899ff9ceeb67ade2086c57f45c4a7fdb941';

final class ProfileDisabledRuleIdsFamily extends $Family
    with
        $ClassFamilyOverride<
          ProfileDisabledRuleIds,
          AsyncValue<List<int>>,
          List<int>,
          Stream<List<int>>,
          int
        > {
  ProfileDisabledRuleIdsFamily._()
    : super(
        retry: null,
        name: r'profileDisabledRuleIdsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileDisabledRuleIdsProvider call(int profileId) =>
      ProfileDisabledRuleIdsProvider._(argument: profileId, from: this);

  @override
  String toString() => r'profileDisabledRuleIdsProvider';
}

abstract class _$ProfileDisabledRuleIds extends $StreamNotifier<List<int>> {
  late final _$args = ref.$arg as int;
  int get profileId => _$args;

  Stream<List<int>> build(int profileId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<int>>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<int>>, List<int>>,
              AsyncValue<List<int>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
