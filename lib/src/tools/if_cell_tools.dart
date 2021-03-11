import 'package:flutter/cupertino.dart';

class IfCellState {
  static IfCellEntity defaultEntity = new IfCellEntity(true, null);

  static Widget getResult(List<IfCellEntity> ifs, BuildContext context) {
    IfCellEntity ifCellEntity =
        ifs.firstWhere((element) => element.expression) ?? defaultEntity;
    return ifCellEntity.cell(context);
  }
}

class IfCellEntity {
  bool expression;
  WidgetBuilder cell;

  IfCellEntity(this.expression, this.cell);
}
