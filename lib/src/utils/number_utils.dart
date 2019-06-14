class NumberUtils {
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static bool intToBool(int i) {
    return i == 1;
  }

  static int boolToInt(bool b) {
    return b ? 1 : 0;
  }

  static T min<T extends num>(T t1, T t2) {
    return t1 < t2 ? t1 : t2;
  }

  static T max<T extends num>(T t1, T t2) {
    return t1 < t2 ? t2 : t1;
  }
}
