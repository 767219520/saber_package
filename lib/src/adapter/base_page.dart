import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  dynamic params;

  BasePage();

  BasePage initWith(dynamic params) {
    this.params = params;
    return this;
  }
}
//abstract class State<T extends StatefulWidget> with Diagnosticable