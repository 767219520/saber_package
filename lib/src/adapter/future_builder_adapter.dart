import 'package:flutter/cupertino.dart';
import 'package:saber_package/src/commonwidgets/future_builder_widget.dart';

abstract class FutureBuilderAdapter {
  FutureBuilderController _futureBuilderController = FutureBuilderController();

  Widget _gethtml(BuildContext context, dynamic data) {
    return gethtml(context);
  }

  Widget buildView([BuildContext context]) {
    return FutureBuilderWidget(_gethtml, (v) {
      return onload();
    }, _futureBuilderController);
  }

  @protected
  Future onload();

  @protected
  Widget gethtml([BuildContext buildContext]);

  void forcedRefresh() {
    _futureBuilderController.reset();
  }

  @mustCallSuper
  @protected
  void dispose() {
    _futureBuilderController.reset();
  }
}
