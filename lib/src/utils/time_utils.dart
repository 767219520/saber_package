class TimeUtils {
  static void setTimeOutSeconds(int seconds, Function f) {
    return setTimeOut(Duration(seconds: seconds), f);
  }

  static void setTimeOut(Duration d, Function f) {
    Future.delayed(d).then((val) {
      if (f != null) f();
    });
  }


  
}
