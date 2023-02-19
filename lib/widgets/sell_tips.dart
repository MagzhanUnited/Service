import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SellTips extends StatelessWidget {
  String first;
  String second;
  String? third;
  var selectedOption;
  var label;
  Function(String) func;
  SellTips(
      {super.key,
      required this.func,
      required this.first,
      required this.second,
      this.third,
      this.selectedOption,
      this.label});

  @override
  Widget build(BuildContext context) {
    return _includeField(first, second, third, selectedOption, label, func);
  }

  Widget _includeField(String first, String second, String? third,
      _selectedOption, String _label, Function(String) func) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        children: [
          Text(_label),
          SizedBox(width: 25),
          third != null
              ? DropdownButton(
                  value: _selectedOption,
                  items: <String>[first, second, third]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    func(value.toString());
                  },
                )
              : DropdownButton(
                  value: _selectedOption,
                  items: <String>[first, second]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    func(value.toString());
                  },
                ),
        ],
      ),
    );
  }
}
