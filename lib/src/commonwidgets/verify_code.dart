import 'dart:async';
import 'package:flutter/material.dart';
class VerifyCode extends StatefulWidget {
  AwaitButtonText getAwaitButtonText;
  Text buttonText;
  int _countdownNum = 0;
  int awaitTime;
  GestureTapCallback onTap;

  VerifyCode(
      {this.buttonText,
      this.getAwaitButtonText,
      this.awaitTime = 60,
      this.onTap});

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  Timer _countdownTimer;
  Text _awaitbuttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget._countdownNum > 0) return;
          widget._countdownNum = widget.awaitTime;
          if (widget.onTap != null) widget.onTap();
        },
        child:
            widget._countdownNum <= 0 ? widget.buttonText : _awaitbuttonText);
  }

  @override
  void initState() {
    _awaitbuttonText = widget.buttonText;
    _countdownTimer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (widget._countdownNum <= 0) {
        widget._countdownNum = 0;
        return;
      }
      widget._countdownNum--;
      if (widget.getAwaitButtonText != null)
        _awaitbuttonText = widget.getAwaitButtonText(widget._countdownNum);
      if (mounted) this.setState(() {});
    });
  }

  @override
  void dispose() {
    if (_countdownTimer != null) _countdownTimer.cancel();
    super.dispose();
  }
}

typedef Widget AwaitButtonText(int v);
