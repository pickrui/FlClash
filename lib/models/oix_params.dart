/// The two profile switches the managed subscription request carries next to
/// `nodes=auto`. Nodes come from the server-side [NodeFilter], so every other
/// stored key is dropped.
class CloudParams {
  final bool? tfo;
  final bool simplerules;

  const CloudParams({this.tfo, this.simplerules = false});

  static CloudParams parse(String raw) {
    final cleaned = raw.trim().replaceFirst(RegExp(r'^[?&]+'), '');
    bool? tfo;
    var simplerules = false;
    for (final pair in cleaned.split('&')) {
      final eq = pair.indexOf('=');
      if (eq < 0) continue;
      final value = _decodeQueryComponent(pair.substring(eq + 1));
      switch (_decodeQueryComponent(pair.substring(0, eq)).toLowerCase()) {
        case 'tfo':
          tfo = switch (value) {
            'true' => true,
            'false' => false,
            _ => null,
          };
        case 'simplerules':
          simplerules = value == 'true';
      }
    }
    return CloudParams(tfo: tfo, simplerules: simplerules);
  }

  String encode() {
    final segments = [
      if (tfo != null) 'tfo=$tfo',
      if (simplerules) 'simplerules=true',
    ];
    return segments.isEmpty ? '' : '&${segments.join('&')}';
  }

  /// The fetcher always wants an explicit `tfo`, so a missing one is false.
  String encodeWithTfo() =>
      CloudParams(tfo: tfo ?? false, simplerules: simplerules).encode();

  @override
  bool operator ==(Object other) =>
      other is CloudParams &&
      tfo == other.tfo &&
      simplerules == other.simplerules;

  @override
  int get hashCode => Object.hash(tfo, simplerules);

  static String _decodeQueryComponent(String value) {
    try {
      return Uri.decodeQueryComponent(value);
    } on FormatException {
      return value;
    }
  }
}

enum NodeFilterChoice {
  any,
  only,
  exclude;

  NodeFilterChoice get next => switch (this) {
    any => only,
    only => exclude,
    exclude => any,
  };
}

/// A client's node filter as `/api/v1/nodes/filter` stores it. Lists hold
/// lower-case line keys and region codes; `match` / `nomatch` are regexes.
class NodeFilter {
  final List<String> includeLines;
  final List<String> excludeLines;
  final List<String> includeRegions;
  final List<String> excludeRegions;
  final String match;
  final String nomatch;

  const NodeFilter({
    this.includeLines = const [],
    this.excludeLines = const [],
    this.includeRegions = const [],
    this.excludeRegions = const [],
    this.match = '',
    this.nomatch = '',
  });

  factory NodeFilter.fromJson(Object? json) {
    if (json is! Map) return const NodeFilter();
    final includeLines = _asKeys(json['include_lines']);
    final includeRegions = _asKeys(json['include_regions']);
    return NodeFilter(
      includeLines: includeLines,
      excludeLines: _asKeys(
        json['exclude_lines'],
      ).where((key) => !includeLines.contains(key)).toList(),
      includeRegions: includeRegions,
      excludeRegions: _asKeys(
        json['exclude_regions'],
      ).where((code) => !includeRegions.contains(code)).toList(),
      match: _asText(json['match']).trim(),
      nomatch: _asText(json['nomatch']).trim(),
    );
  }

  Map<String, Object> toJson() => {
    'include_lines': includeLines,
    'exclude_lines': excludeLines,
    'include_regions': includeRegions,
    'exclude_regions': excludeRegions,
    'match': match.trim(),
    'nomatch': nomatch.trim(),
  };

  bool get isEmpty =>
      includeLines.isEmpty &&
      excludeLines.isEmpty &&
      includeRegions.isEmpty &&
      excludeRegions.isEmpty &&
      match.trim().isEmpty &&
      nomatch.trim().isEmpty;

  NodeFilterChoice lineChoice(String key) =>
      _choice(key, includeLines, excludeLines);

  NodeFilterChoice regionChoice(String code) =>
      _choice(code, includeRegions, excludeRegions);

  NodeFilter cycleLine(String key) {
    final (include, exclude) = _cycle(
      key,
      lineChoice(key).next,
      includeLines,
      excludeLines,
    );
    return _copy(includeLines: include, excludeLines: exclude);
  }

  NodeFilter cycleRegion(String code) {
    final (include, exclude) = _cycle(
      code,
      regionChoice(code).next,
      includeRegions,
      excludeRegions,
    );
    return _copy(includeRegions: include, excludeRegions: exclude);
  }

  NodeFilter copyWith({String? match, String? nomatch}) =>
      _copy(match: match, nomatch: nomatch);

  NodeFilter _copy({
    List<String>? includeLines,
    List<String>? excludeLines,
    List<String>? includeRegions,
    List<String>? excludeRegions,
    String? match,
    String? nomatch,
  }) {
    return NodeFilter(
      includeLines: includeLines ?? this.includeLines,
      excludeLines: excludeLines ?? this.excludeLines,
      includeRegions: includeRegions ?? this.includeRegions,
      excludeRegions: excludeRegions ?? this.excludeRegions,
      match: match ?? this.match,
      nomatch: nomatch ?? this.nomatch,
    );
  }

  static NodeFilterChoice _choice(
    String key,
    List<String> include,
    List<String> exclude,
  ) {
    if (include.contains(key)) return NodeFilterChoice.only;
    if (exclude.contains(key)) return NodeFilterChoice.exclude;
    return NodeFilterChoice.any;
  }

  static (List<String>, List<String>) _cycle(
    String key,
    NodeFilterChoice choice,
    List<String> include,
    List<String> exclude,
  ) {
    return (
      [
        ...include.where((item) => item != key),
        if (choice == NodeFilterChoice.only) key,
      ],
      [
        ...exclude.where((item) => item != key),
        if (choice == NodeFilterChoice.exclude) key,
      ],
    );
  }

  @override
  bool operator ==(Object other) =>
      other is NodeFilter &&
      _sameItems(includeLines, other.includeLines) &&
      _sameItems(excludeLines, other.excludeLines) &&
      _sameItems(includeRegions, other.includeRegions) &&
      _sameItems(excludeRegions, other.excludeRegions) &&
      match.trim() == other.match.trim() &&
      nomatch.trim() == other.nomatch.trim();

  @override
  int get hashCode => Object.hash(
    Object.hashAllUnordered(includeLines),
    Object.hashAllUnordered(excludeLines),
    Object.hashAllUnordered(includeRegions),
    Object.hashAllUnordered(excludeRegions),
    match.trim(),
    nomatch.trim(),
  );

  static bool _sameItems(List<String> a, List<String> b) =>
      a.length == b.length && a.toSet().containsAll(b);
}

class NodeFilterLine {
  final String key;
  final String name;
  final int count;

  const NodeFilterLine({
    required this.key,
    required this.name,
    required this.count,
  });

  factory NodeFilterLine.fromJson(Map<dynamic, dynamic> json) {
    final key = _asText(json['key']).trim().toLowerCase();
    final name = _asText(json['name']).trim();
    return NodeFilterLine(
      key: key,
      name: name.isEmpty ? key : name,
      count: _asCount(json['count']),
    );
  }
}

class NodeFilterRegion {
  final String code;
  final String name;
  final String emoji;
  final int count;

  const NodeFilterRegion({
    required this.code,
    required this.name,
    required this.emoji,
    required this.count,
  });

  factory NodeFilterRegion.fromJson(Map<dynamic, dynamic> json) {
    final code = _asText(json['code']).trim().toLowerCase();
    final name = _asText(json['name']).trim();
    return NodeFilterRegion(
      code: code,
      name: name.isEmpty ? code.toUpperCase() : name,
      emoji: _asText(json['emoji']).trim(),
      count: _asCount(json['count']),
    );
  }
}

class NodeFilterNode {
  final String name;
  final String line;
  final String region;
  final bool kept;

  const NodeFilterNode({
    required this.name,
    required this.line,
    required this.region,
    required this.kept,
  });

  factory NodeFilterNode.fromJson(Map<dynamic, dynamic> json) {
    return NodeFilterNode(
      name: _asText(json['name']).trim(),
      line: _asText(json['line']).trim().toLowerCase(),
      region: _asText(json['region']).trim().toLowerCase(),
      kept: _asBool(json['kept']),
    );
  }
}

/// The node catalog every `/api/v1/nodes/filter*` endpoint answers with.
/// `kept` follows the requested filter, or the plan default lines without one.
class NodeFilterCatalog {
  final bool available;
  final bool customized;
  final bool systemLink;
  final NodeFilter filter;
  final List<String> defaultLines;
  final List<NodeFilterLine> lines;
  final List<NodeFilterRegion> regions;
  final List<NodeFilterNode> nodes;
  final int kept;
  final int total;

  const NodeFilterCatalog({
    this.available = true,
    this.customized = false,
    this.systemLink = false,
    this.filter = const NodeFilter(),
    this.defaultLines = const [],
    this.lines = const [],
    this.regions = const [],
    this.nodes = const [],
    this.kept = 0,
    this.total = 0,
  });

  factory NodeFilterCatalog.fromJson(Map<dynamic, dynamic> json) {
    final filter = NodeFilter.fromJson(json['filter']);
    final nodes = _asMaps(json['nodes'])
        .map(NodeFilterNode.fromJson)
        .where((node) => node.name.isNotEmpty)
        .toList();
    return NodeFilterCatalog(
      available: json['available'] == null || _asBool(json['available']),
      customized: json['customized'] == null
          ? !filter.isEmpty
          : _asBool(json['customized']),
      systemLink: _asBool(json['system_link']),
      filter: filter,
      defaultLines: _asKeys(json['default_lines']),
      lines: _uniqueBy(
        _asMaps(json['lines']).map(NodeFilterLine.fromJson),
        (line) => line.key,
      ),
      regions: _uniqueBy(
        _asMaps(json['regions']).map(NodeFilterRegion.fromJson),
        (region) => region.code,
      ),
      nodes: nodes,
      kept: _tryCount(json['kept']) ?? nodes.where((node) => node.kept).length,
      total: _tryCount(json['total']) ?? nodes.length,
    );
  }

  /// Names of the plan default lines that have nodes, with the three Fusion
  /// tiers shown once. Empty means every node is delivered.
  List<String> get defaultLineNames {
    final present = {
      for (final line in lines)
        if (line.count > 0) line.key: line.name,
    };
    final names = <String>[];
    for (final key in defaultLines) {
      final name = present[key];
      if (name == null) continue;
      final label = key.startsWith('fusion')
          ? present['fusion'] ?? 'Fusion'
          : name;
      if (!names.contains(label)) names.add(label);
    }
    return names;
  }
}

String _asText(Object? value) => value == null ? '' : value.toString();

bool _asBool(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  return const {'true', '1'}.contains(value?.toString().trim().toLowerCase());
}

int? _tryCount(Object? value) {
  final count = value is num
      ? value.toInt()
      : int.tryParse(value?.toString().trim() ?? '');
  return count == null || count < 0 ? null : count;
}

int _asCount(Object? value) => _tryCount(value) ?? 0;

List<Map<dynamic, dynamic>> _asMaps(Object? value) =>
    value is List ? value.whereType<Map>().toList() : const [];

List<String> _asKeys(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Object>()
      .map((item) => item.toString().trim().toLowerCase())
      .where((item) => item.isNotEmpty)
      .toSet()
      .toList();
}

List<T> _uniqueBy<T>(Iterable<T> items, String Function(T item) key) {
  final seen = <String>{};
  return [
    for (final item in items)
      if (key(item).isNotEmpty && seen.add(key(item))) item,
  ];
}
