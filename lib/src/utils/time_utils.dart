class TimeUtils {
  static void setTimeOutSeconds(int seconds, Function f) {
    setTimeOut(Duration(seconds: seconds), f);
  }

  static int setTimeOut(Duration d, LoopFunc f, [int loopCount = 1]) {
    if (f == null || loopCount <= 0) return 0;
    Future.delayed(d).then((value) {
      f(loopCount);
      setTimeOut(d, f, loopCount - 1);
    });
    return loopCount;
  }

  static void setTimeOutLoop(Duration d, Function f) {
    if (f == null) return;
    Future.delayed(d).then((value) {
      f();
      setTimeOutLoop(d, f);
    });
  }

  static void loop(LoopFunc f, [int loopMaxCount = 1]) {
    if (f == null || loopMaxCount <= 0) return;
    f(loopMaxCount);
    loop(f, loopMaxCount - 1);
  }
}

typedef void LoopFunc(int loopCount);
