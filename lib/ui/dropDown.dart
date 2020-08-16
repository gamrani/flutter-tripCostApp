import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  var items = ["default"];
  String _currency = "Dollors";

  DropDownWidget(this.items);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: this.items.map((String value) {
          print(value);
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        value: _currency,
        onChanged: (String value) {
          _onDropDownChanged(value);
        });
  }

  void _onDropDownChanged(String value) {
    this._currency = value;
  }
}
