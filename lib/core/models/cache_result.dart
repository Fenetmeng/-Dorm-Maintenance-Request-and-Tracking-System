class CacheResult<T> {
  final T data;
  final bool fromCache;

  CacheResult({
    required this.data,
    required this.fromCache,
  });
}