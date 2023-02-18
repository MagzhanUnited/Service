import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/my_flutter_app_icons.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              'Тема',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(child: Container()),
            Icon(NewIcons.moon),
            SizedBox(width: 5),
            Switch(
                value: _isSwitched,
                onChanged: (val) => setState(() {
                      _isSwitched = !_isSwitched;
                    })),
            SizedBox(width: 5),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 650),
          padding: EdgeInsets.all(15),
          child: Text(
            'Выход',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        )
      ]),
    );
  }
}
