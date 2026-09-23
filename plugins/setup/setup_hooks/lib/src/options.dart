class BuildConfig {
  const BuildConfig({
    required this.tags,
    required this.goLdflags,
    required this.coreDir,
    required this.coreName,
    required this.libName,
    required this.outputDir,
    required this.helperDir,
    required this.helperName,
    this.coreSecretFlags = '',
  });

  final String coreSecretFlags;

  BuildConfig withCoreSecrets(String flags) => BuildConfig(
    tags: tags,
    goLdflags: goLdflags,
    coreDir: coreDir,
    coreName: coreName,
    libName: libName,
    outputDir: outputDir,
    helperDir: helperDir,
    helperName: helperName,
    coreSecretFlags: flags,
  );

  final String tags;
  final String goLdflags;
  final String coreDir;
  final String coreName;
  final String libName;
  final String outputDir;
  final String helperDir;
  final String helperName;

  /// The only build configuration: packaging paths are fixed in CMake, Gradle
  /// and Xcode, and test/lint/go_build_tags_test.dart pins [tags].
  static const release = BuildConfig(
    tags: 'with_gvisor,with_mips_low_memory',
    goLdflags: '-w -s -buildid=',
    coreDir: 'core',
    coreName: 'FlClashCore',
    libName: 'libclash',
    outputDir: 'libclash',
    helperDir: 'services/helper',
    helperName: 'FlClashHelperService',
  );

  Map<String, String> toFingerprintMap() => {
    'tags': tags,
    'core_secret_flags': coreSecretFlags,
    'go_ldflags': goLdflags,
    'core_dir': coreDir,
    'core_name': coreName,
    'lib_name': libName,
    'output_dir': outputDir,
    'helper_dir': helperDir,
    'helper_name': helperName,
  };
}
