import 'iterable.dart';

class FixedList<T> {
  final int maxLength;
  final List<T> _list;

  FixedList(this.maxLength, {List<T>? list})
    : _list = (list ?? [])..truncate(maxLength);

  void add(T item) {
    _list.add(item);
    _list.truncate(maxLength);
  }

  void clear() {
    _list.clear();
  }

  List<T> get list => List.unmodifiable(_list);

  int get length => _list.length;

  T operator [](int index) => _list[index];

  FixedList<T> copyWith() {
    return FixedList(maxLength, list: List.of(_list));
  }
}
