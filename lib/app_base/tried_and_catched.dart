// runs a future which might throw, caches either result or exception throws

Future<TriedAndCatched<T>> tryCatch<T>(
  Future<T> f,
) async {
  try {
    final data = await f;
    return TriedAndCatched(data, null, null);
  } catch (e, s) {
    return TriedAndCatched(null, e, s);
  }
}

class TriedAndCatched<T> {
  final T? _data;
  final Object? err;
  final StackTrace? st;

  TriedAndCatched(this._data, this.err, this.st);

  //returns only if the err is null otherwise throws
  T get data => _data as T;
}
