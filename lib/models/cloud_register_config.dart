class CloudRegisterConfig {
  final String registerMode;
  final bool registerEnabled;
  final bool inviteRequired;
  final bool emailVerify;
  final bool turnstile;
  final String appName;

  const CloudRegisterConfig({
    required this.registerMode,
    required this.registerEnabled,
    required this.inviteRequired,
    required this.emailVerify,
    required this.turnstile,
    required this.appName,
  });

  factory CloudRegisterConfig.fromJson(Map<String, dynamic> json) {
    bool asBool(dynamic v) => v == true || v == 1 || v == '1' || v == 'true';
    return CloudRegisterConfig(
      registerMode: json['register_mode']?.toString() ?? 'open',
      registerEnabled: asBool(json['register_enabled']),
      inviteRequired: asBool(json['invite_required']),
      emailVerify: asBool(json['email_verify']),
      turnstile: asBool(json['turnstile']),
      appName: json['app_name']?.toString() ?? '',
    );
  }

  static const fallback = CloudRegisterConfig(
    registerMode: 'open',
    registerEnabled: true,
    inviteRequired: false,
    emailVerify: false,
    turnstile: false,
    appName: '',
  );
}
