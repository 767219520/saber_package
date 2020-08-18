import 'package:flutter/cupertino.dart';

class IfCellState {
  static IfCellEntity defaultEntity=new IfCellEntity(true,null);

  static dynamic getResult(List<IfCellEntity> ifs) {
    IfCellEntity ifCellEntity= ifs.firstWhere((element) => element.expression)??defaultEntity;
    return ifCellEntity.cell;
  }
}

class IfCellEntity {
  bool expression;
  dynamic cell;

  IfCellEntity(this.expression, this.cell);
}
