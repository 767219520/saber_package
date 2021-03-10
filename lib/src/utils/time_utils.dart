class TimeUtils {
  static void setTimeOutSeconds(int seconds, Function f) {
    setTimeOut(Duration(seconds: seconds), f);
  }

  static int setTimeOut(Duration d, Function f, [int loopCount = 1]) {
    if (f == null || loopCount <= 0) return 0;
    Future.delayed(d).then((value) {
      f();
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

  void loop(Function f, [int loopMaxCount = 1]) {
    if (f == null || loopMaxCount <= 0) return;
    f();
    loop(f, loopMaxCount - 1);
  }
}
