part of 'database.dart';

class StringMapConverter extends TypeConverter<Map<String, String>, String> {
  const StringMapConverter();

  @override
  Map<String, String> fromSql(String fromDb) {
    return Map<String, String>.from(json.decode(fromDb));
  }

  @override
  String toSql(Map<String, String> value) {
    return json.encode(value);
  }
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class StringSetConverter extends TypeConverter<Set<String>, String> {
  const StringSetConverter();

  @override
  Set<String> fromSql(String fromDb) {
    return Set<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(Set<String> value) {
    return json.encode(value.toList());
  }
}

class JsonValueConverter extends TypeConverter<Object?, String?> {
  const JsonValueConverter();
  @override
  Object? fromSql(String? fromDb) =>
      fromDb == null ? null : json.decode(fromDb);
  @override
  String? toSql(Object? value) => value == null ? null : json.encode(value);
}
