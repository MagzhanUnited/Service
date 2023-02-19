import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  MessageView(
      {super.key,
      required this.title,
      required this.color,
      this.colorText = Colors.white});
  String title;
  Color color;
  Color colorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 40,
      child: Text(
        title,
        style: TextStyle(fontSize: 15, color: colorText),
      ),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }
}
