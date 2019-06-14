import 'package:flutter/material.dart';

class SelectWidget extends StatefulWidget {
  final List<Option> options;
  ValueChanged<String> onChanged;
  String value;

  SelectWidget({this.options, this.value, this.onChanged});

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> lst = widget.options
        .map((Option tab) => DropdownMenuItem(
              child: tab,
              value: tab.value,
            ))
        .toList();
    DropdownMenuItem<String> first = lst.firstWhere((item) {
      return (widget.value == null || widget.value.isEmpty) ||
          item.value == widget.value;
    }, orElse: () {
      return lst[0];
    });

    var drop = DropdownButton(
        items: lst,
        value: first.value,
//        hint: Container(
//
//          width: 10,
//          decoration: BoxDecoration(color: Colors.red),
//        ),
        onChanged: (String v) {
          widget.value = v;
          setState(() {});
          if (widget.onChanged != null) widget.onChanged(v);
        });
    return DropdownButtonHideUnderline(child: drop);
  }
}

class Option extends StatelessWidget {
  Widget child;
  String value;

  Option({@required this.child, @required this.value});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
