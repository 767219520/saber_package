import 'dart:async';

class CountDown {
  int value;
  bool auto;
  Timer _countdownTimer;
  CallBack callBack;
  int rate;
  OverCallBack overCallBack;

  CountDown(
      {this.value = 60,
      this.auto = true,
      this.callBack,
      this.rate = 1000,
      this.overCallBack}) {
    if (auto) Start();
  }

  void Start() {
    if (_countdownTimer != null) return;
    _countdownTimer = Timer.periodic(Duration(milliseconds: rate), (t) {
      value--;
      if (callBack == null && value <= 0) cancel();
      if (callBack != null) {
        bool r = callBack(this);
        if (r == true) {
          cancel();
          if (overCallBack != null) overCallBack(this);
        }
      }
    });
  }

  void cancel() {
    if (_countdownTimer == null) return;
    _countdownTimer.cancel();
    _countdownTimer = null;
  }
}

typedef bool CallBack(CountDown count);
typedef void OverCallBack(CountDown count);
