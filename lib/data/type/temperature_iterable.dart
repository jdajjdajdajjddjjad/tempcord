part of 'temperature.dart';

mixin TemperatureIterableMixin<T extends Temperature> on Iterable<T> {
  @override
  bool contains(Object? element) {
    for (T t in this) {
      if (t._objectHash == element.hashCode) {
        return true;
      }
    }

    return false;
  }

  @override
  List<T> toList({bool growable = true}) => growable
      ? TemperatureList.from(this)
      : TemperatureList.unmodifiable(this);

  @override
  Set<T> toSet() => TemperatureSet.from(this);

  Set<T> toUnmodifiableSet() => TemperatureSet.unmodifiable(this);
}

abstract class TemperatureList<T extends Temperature>
    with ListMixin<T>, TemperatureIterableMixin<T> {
  factory TemperatureList() => _TemperatureList(<T>[]);

  factory TemperatureList.from(Iterable<T> source) => _TemperatureList(source);

  factory TemperatureList.unmodifiable(Iterable<T> source) =>
      _UnmodifiableTemperatureList(source);
}

class _TemperatureList<T extends Temperature> extends ListBase<T>
    with TemperatureIterableMixin<T>
    implements TemperatureList<T> {
  final List<T> _list;

  _TemperatureList(Iterable<T> list) : _list = List.from(list);

  @override
  set length(int length) => _list.length = length;

  @override
  int get length => _list.length;

  @override
  T operator [](int index) => _list[index];

  @override
  void operator []=(int index, T value) => _list[index] = value;
}

class _UnmodifiableTemperatureList<T extends Temperature>
    extends UnmodifiableListView<T>
    with TemperatureIterableMixin<T>
    implements TemperatureList<T> {
  _UnmodifiableTemperatureList(Iterable<T> source) : super(source);
}

abstract class TemperatureSet<T extends Temperature>
    with SetMixin<T>, TemperatureIterableMixin<T> {
  factory TemperatureSet() => _TemperatureSet(<T>{});

  factory TemperatureSet.from(Iterable<T> source) => _TemperatureSet(source);

  factory TemperatureSet.unmodifiable(Iterable<T> source) =>
      _UnmodifiableTemperatureSet(source);
}

class _TemperatureSet<T extends Temperature> extends SetBase<T>
    with TemperatureIterableMixin<T>
    implements TemperatureSet<T> {
  final Set<T> _sets;

  _TemperatureSet(Iterable<T> sets) : _sets = Set.from(sets);

  @override
  bool add(T value) => _sets.add(value);

  @override
  Iterator<T> get iterator => _sets.iterator;

  @override
  int get length => _sets.length;

  @override
  T? lookup(Object? element) => _sets.lookup(element);

  @override
  bool remove(Object? value) => _sets.remove(value);
}

class _UnmodifiableTemperatureSet<T extends Temperature>
    extends UnmodifiableSetView<T>
    with TemperatureIterableMixin<T>
    implements TemperatureSet<T> {
  _UnmodifiableTemperatureSet(Iterable<T> source) : super(Set.from(source));
}
