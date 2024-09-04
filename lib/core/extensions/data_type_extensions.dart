extension Group<T> on Iterable<T> {
  Groups<K, T> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final keyValue = key(element);
      if (!map.containsKey(keyValue)) {
        map[keyValue] = [];
      }
      map[keyValue]?.add(element);
    }
    return Groups(keys: map.keys.toList(), children: map.values.toList());
  }
}

class Groups<K, T> {
  const Groups({
    required this.keys,
    required this.children,
  });
  final List<K> keys;
  final List<List<T>> children;

  @override
  String toString() {
    return 'Groups{keys: $keys, children: $children}';
  }

  factory Groups.empty() {
    return const Groups(keys: [], children: []);
  }

  List<T> expands() => children.fold(<T>[], (pv, e) => [...pv, ...e]);
}
