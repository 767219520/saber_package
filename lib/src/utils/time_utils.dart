class TimeUtils {
  static Future setTimeOutSeconds(int seconds, LoopFunc f) {
    return setTimeOut(Duration(seconds: seconds), f, 1);
  }

  static Future setTimeOut(Duration d, LoopFunc f, [int loopMaxCount = 1]) {
    if (f == null || loopMaxCount <= 0) return Future.value(false);
    return Future.delayed(d).then((value) {
      f(loopMaxCount);
      setTimeOut(d, f, loopMaxCount - 1);
    });
  }

  static Future setTimeOutLoop(Duration d, LoopFunc f,
      [int loopStartCount = 0]) {
    loopStartCount++;
    if (f == null) return Future.value(false);
    return Future.delayed(d).then((value) {
      f(loopStartCount);
      return setTimeOutLoop(d, f, loopStartCount);
    });
  }

  static Future loop(LoopFunc f, [int loopMaxCount = 1]) {
    if (f == null || loopMaxCount <= 0) return Future.value(false);
    f(loopMaxCount);
    return loop(f, loopMaxCount - 1);
  }
}

typedef void LoopFunc(int loopCount);
