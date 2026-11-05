/// Panel timestamps without an offset use the server's Asia/Shanghai timezone.
DateTime? parseCloudPanelTime(String raw) {
  final value = raw.trim();
  final match = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2}):(\d{2})(?:\.\d+)?(?:Z|[+-]\d{2}:?\d{2})?$',
  ).firstMatch(value);
  if (match == null) return null;
  final parts = [for (var i = 1; i <= 6; i++) int.parse(match.group(i)!)];
  final date = DateTime.utc(
    parts[0],
    parts[1],
    parts[2],
    parts[3],
    parts[4],
    parts[5],
  );
  if (date.year != parts[0] ||
      date.month != parts[1] ||
      date.day != parts[2] ||
      date.hour != parts[3] ||
      date.minute != parts[4] ||
      date.second != parts[5]) {
    return null;
  }
  final hasZone = RegExp(r'(Z|[+-]\d{2}:?\d{2})$').hasMatch(value);
  return DateTime.tryParse(
    hasZone ? value : '${value.replaceFirst(' ', 'T')}+08:00',
  );
}
