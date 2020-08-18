import 'package:flutter/cupertino.dart';

class IfCellState {
  static IfCellEntity defaultEntity=new IfCellEntity(true,null);

  static dynamic getResult(List<IfCellEntity> ifs) {
    IfCellEntity(true, 1);
    return ifs.firstWhere((element) => element.expression);
  }

//  dynamic getResult1(
//      [IfCellEntity part1,
//        IfCellEntity part2]) {
//
//    return ifs.firstWhere((element) => element.expression);
//  }
}

class IfCellEntity {
  bool expression;
  dynamic cell;

  IfCellEntity(this.expression, this.cell);
}
