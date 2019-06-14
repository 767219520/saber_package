import 'package:flutter/material.dart';
import 'package:saber_package/src/commonwidgets/scaffold_state_widget.dart';
import 'package:saber_package/src/tools/route_tools.dart';
import 'package:saber_package/src/utils/color_utils.dart';
import 'package:saber_package/src/utils/string_utils.dart';
import 'falls_widget.dart';

class IdcardKeyboardWidgetController {
  VoidCallback _showBottomSheetCallback;
  ValueChanged<String> _onSubmitted;
  static const List<String> _keyNames = [
    '1',
    '2',
    '3',
    '删除',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '隐藏',
    'x',
    '0',
    '确定'
  ];
  TextEditingController searchController = TextEditingController();
  final ScaffoldStateController scaffoldStateController;

  IdcardKeyboardWidgetController(@required this.scaffoldStateController,
      @required this._onSubmitted, @required this._page) {
    _showBottomSheetCallback = _showBottomSheet;
  }

  State _page;

  void showKeyboard() {
    _showBottomSheet();
  }

  void _showBottomSheet() {
    _page.setState(() {
      _showBottomSheetCallback = null;
    });

    scaffoldStateController
        .getScaffoldState()
        .showBottomSheet<void>((BuildContext context) {
          return _getbottomInput(context, 0);
        })
        .closed
        .whenComplete(() {
          if (_page.mounted) {
            _page.setState(() {
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  T _getbottomInput<T extends Object>([BuildContext context, int index = 0]) {
    Object bottomInput = Container(
        child: Container(
            child: Column(children: [
          Container(
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入身份证号",
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      hintStyle:
                          TextStyle(color: Color(0xFF252525), fontSize: 15)),
                  style: TextStyle(color: Color(0xFF000000)),
                  controller: searchController,
                  enabled: false),
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5)))),
          Expanded(
              child: Container(
                  child: Falls(
                      itemCount: 14,
                      itemBuilder: _bottomInputItemBuilder,
                      rowCount: 16,
                      bottomMargin: 1,
                      rightMargin: 1,
                      spanitemBuilder: _spanitemBuilder),
                  padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10)))
        ])),
        height: 550,
        decoration: BoxDecoration(color: Color(0xFFD2D5DA)));
    return bottomInput;
  }

  Widget _bottomInputItemBuilder(BuildContext c, int index) {
    var text = Text(_keyNames[index],
        style: TextStyle(color: ColorUtils.getColor("#080808"), fontSize: 20));
    return FlatButton(
        color: ColorUtils.getColor("#FFFFFF"),
        onPressed: () {
          _onPressed(c, index);
        },
        child: text);
  }

  Staggered _spanitemBuilder(BuildContext context, int index) {
    if (index == 3 || index == 10) return Staggered(4, 6);
    return Staggered(4, 3);
  }

  void _onPressed(BuildContext context, int index) {
    var text = searchController.text.trim();
    if (index == 3) {
      if (StringUtils.isEmpty(text)) return;
      searchController.text = text.substring(0, text.length - 1);
      return;
    } else if (index == 10) {
      searchController.text = "";
      RouteTools.pagegoBack(context);
    } else if (index == 13) {
      searchController.text = "";
      RouteTools.pagegoBack(context);
      _onSubmitted(text);
    } else if (text.length < 18)
      searchController.text = text + _keyNames[index];
  }
}
