import 'package:flutter/cupertino.dart';
import 'package:saber_package/saber_commonwidgets.dart';
import 'package:saber_package/src/commonwidgets/future_builder_widget.dart';

abstract class FutureBuilderAdapter {
  FutureBuilderController _futureBuilderController = FutureBuilderController();

  FutureBuilderController get futureBuilderController =>
      _futureBuilderController;
  bool hasWillPop = false;

  Widget _gethtml(BuildContext context, dynamic data) {
    if (hasWillPop)
      return WillPopScopeWidget(gethtml(context));
    else
      return gethtml(context);
  }

  Widget buildView([BuildContext context]) {
    return FutureBuilderWidget(
      _gethtml,
          (v) {
        return onload();
      },
      _futureBuilderController,
      key: Key("${DateTime
          .now()
          .millisecond}"),
    );
  }

  @protected
  Future onload();

  @protected
  Widget gethtml([BuildContext buildContext]);


  void setState() {
    _futureBuilderController.setState();
  }

  void forcedRefresh() {
    _futureBuilderController.reset();
  }

  @mustCallSuper
  @protected
  void dispose() {
    _futureBuilderController.reset();
  }
}
