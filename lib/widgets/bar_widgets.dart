import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BarWidgets extends StatefulWidget {
  IconData icon;
  String title;
  Function func;

  BarWidgets(
      {super.key, required this.icon, required this.title, required this.func});

  @override
  State<BarWidgets> createState() => _BarWidgetsState();
}

class _BarWidgetsState extends State<BarWidgets> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.02, top: 10),
        padding: EdgeInsets.symmetric(vertical: 15),
        height: 80,
        width: MediaQuery.of(context).size.width * 0.23,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
            ),
            Text(
              widget.title,
            )
          ],
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: Offset(5.0, 5.0),
            blurRadius: 10.0,
          )
        ], color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      ),
      onTap: () {
        widget.func();
      },
    );
  }
}
