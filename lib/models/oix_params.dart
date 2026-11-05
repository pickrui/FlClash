enum SubscriptionTier {
  none,
  bronze,
  premium;

  static SubscriptionTier fromServer(String? raw) {
    final s = raw?.trim() ?? '';
    if (s.isEmpty || s == 'null' || s == 'Pass Iron') return none;
    if (s == 'Pass Bronze') return bronze;
    return premium;
  }

  bool get canUseEmergency => this == premium;

  OixParams get defaultParams => switch (this) {
    none => const OixParams(),
    bronze => const OixParams(level: NetworkLevel.emergency),
    premium => const OixParams(type: 'love'),
  };
}

enum NetworkLevel {
  overseas('1'),
  emergency('2');

  final String value;
  const NetworkLevel(this.value);

  static NetworkLevel? fromValue(String? v) {
    for (final lv in NetworkLevel.values) {
      if (lv.value == v) return lv;
    }
    return null;
  }
}

class OixParams {
  final NetworkLevel? level;
  final String? type;
  final bool? tfo;
  final bool simplerules;
  final Map<String, String> extras;

  const OixParams({
    this.level,
    this.type,
    this.tfo,
    this.simplerules = false,
    this.extras = const {},
  });

  static OixParams parse(String raw) {
    final cleaned = raw.startsWith('&') ? raw.substring(1) : raw;
    if (cleaned.isEmpty) return const OixParams();

    NetworkLevel? level;
    String? type;
    bool? tfo;
    bool simplerules = false;
    final extras = <String, String>{};

    for (final pair in cleaned.split('&')) {
      if (pair.isEmpty) continue;
      final eq = pair.indexOf('=');
      if (eq < 0) {
        extras[pair] = '';
        continue;
      }
      final k = pair.substring(0, eq);
      final v = pair.substring(eq + 1);
      switch (k) {
        case 'lv':
          level = NetworkLevel.fromValue(v);
          if (level == null) extras[k] = v;
        case 'type':
          type = v;
        case 'tfo':
          if (v == 'true') tfo = true;
          if (v == 'false') tfo = false;
        case 'simplerules':
          simplerules = v == 'true';
        default:
          extras[k] = v;
      }
    }

    return OixParams(
      level: level,
      type: type,
      tfo: tfo,
      simplerules: simplerules,
      extras: extras,
    );
  }

  String encode() {
    final segments = <String>[];
    if (level != null) segments.add('lv=${level!.value}');
    if (type != null && type!.isNotEmpty) segments.add('type=$type');
    if (tfo != null) segments.add('tfo=$tfo');
    if (simplerules) segments.add('simplerules=true');
    extras.forEach((k, v) {
      if (k.isEmpty) return;
      segments.add(v.isEmpty ? k : '$k=$v');
    });
    if (segments.isEmpty) return '';
    return '&${segments.join('&')}';
  }

  /// URL-suffix form guaranteed to include a `tfo` segment (defaults to true).
  /// Used when handing off to the fetcher, which always wants an explicit value.
  String encodeWithTfo() {
    final withTfo = tfo == null ? copyWith(tfo: true) : this;
    return withTfo.encode();
  }

  OixParams copyWith({
    Object? level = _sentinel,
    Object? type = _sentinel,
    Object? tfo = _sentinel,
    Object? simplerules = _sentinel,
    Map<String, String>? extras,
  }) {
    return OixParams(
      level: level == _sentinel ? this.level : level as NetworkLevel?,
      type: type == _sentinel ? this.type : type as String?,
      tfo: tfo == _sentinel ? this.tfo : tfo as bool?,
      simplerules: simplerules == _sentinel
          ? this.simplerules
          : simplerules as bool,
      extras: extras ?? this.extras,
    );
  }

  /// Encoded form excluding independent switches. Used to compare with tier
  /// defaults, which only own routing params like level/type.
  String encodeDefaultComparable() => copyWith(
    tfo: null,
    simplerules: false,
  ).encode();

  String encodeEditableOptions() => encodeDefaultComparable();

  /// Strip emergency mode if the current [tier] cannot support it.
  OixParams stripEmergencyIfUnsupported(SubscriptionTier tier) {
    if (level == NetworkLevel.emergency &&
        !tier.canUseEmergency &&
        tier != SubscriptionTier.bronze) {
      return copyWith(level: null);
    }
    return this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OixParams) return false;
    if (level != other.level ||
        type != other.type ||
        tfo != other.tfo ||
        simplerules != other.simplerules) {
      return false;
    }
    if (extras.length != other.extras.length) return false;
    for (final e in extras.entries) {
      if (other.extras[e.key] != e.value) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var extrasHash = 0;
    for (final extra in extras.entries) {
      extrasHash ^= Object.hash(extra.key, extra.value);
    }
    return Object.hash(
      level,
      type,
      tfo,
      simplerules,
      extras.length,
      extrasHash,
    );
  }
}

const _sentinel = Object();
