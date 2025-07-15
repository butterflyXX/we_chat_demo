extension NullSafeBlock<T> on T {
  T also(Function(T it) runnable) {
    final instance = this;
    runnable(instance);
    return instance;
  }

  U let<U>(U Function(T it) runnable) {
    return runnable(this);
  }

  T? takeIf(bool Function(T it) predicate) {
    return predicate(this) ? this : null;
  }

  T? takeUnless(bool Function(T it) predicate) {
    return predicate(this) ? this : null;
  }

  T? alsoIf(bool Function(T it) predicate, Function(T it) runnable) {
    if (predicate(this)) {
      runnable(this);
    }
    return this;
  }

  T? alsoUnless(bool Function(T it) predicate, Function(T it) runnable) {
    if (!predicate(this)) {
      runnable(this);
    }
    return this;
  }


}