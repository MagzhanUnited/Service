import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/my_flutter_app_icons.dart';
import 'package:flutter_everything/pages/everything.dart';
import 'package:flutter_everything/pages/heart_page.dart';
import 'package:flutter_everything/pages/message_page.dart';
import 'package:flutter_everything/pages/personal_page.dart';
import 'package:flutter_everything/pages/sell_page.dart';
import 'package:get/get.dart';

import '../context_size.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  int _selected = 0;
  List<Widget> _widgets = [
    Everything(),
    HeartPage(),
    SellPage(),
    MessagePage(),
    PersonalPage()
  ];
  @override
  Widget build(BuildContext context) {
    ContextSize.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'BARLYK',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Новости',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selected,
        onTap: (value) => setState(() {
          _selected = value;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главный'),
          BottomNavigationBarItem(
              icon: Icon(NewIcons.heart), label: 'Избранное'),
          BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.sell,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    border: Border.all(color: Colors.blue, width: 1)),
              ),
              label: 'Подать'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline), label: 'Сообщения'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Кабинет')
        ],
      ),
      body: _widgets[_selected],
    );
  }
}
