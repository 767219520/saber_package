class TimeUtils {
  static void setTimeOutSeconds(int seconds, Function f) {
    return setTimeOut(Duration(seconds: seconds), f);
  }

  static void setTimeOut(Duration d, Function f, [int loopCount = 1]) {
    if (f == null || loopCount <= 0) return;
    Future.delayed(d).then((value) {
      setTimeOut(d, f, loopCount - 1);
    });
  }

  static void setTimeOutLoop(Duration d, Function f) {
    if (f == null) return;
    Future.delayed(d).then((value) {
      setTimeOutLoop(d, f);
    });
  }
}
