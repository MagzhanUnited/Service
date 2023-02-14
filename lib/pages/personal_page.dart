import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/inner_pages/reg_inner_page.dart';
import 'package:flutter_everything/message_features/ai_manager.dart';
import 'package:flutter_everything/widgets/suggest_reg_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import '../controllers/user_controller.dart';
import '../inner_pages/personal_inners/my_ads.dart';

class PersonalPage extends StatelessWidget {
  UserController _userController = Get.find();
  PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _userController.userData.value == null ? SuggestRegPage() : _page());
  }

  Widget _page() {
    return Column(
      children: [
        _exist(),
        _personalInf(),
        SizedBox(
          height: 30,
        ),
        _support()
      ],
    );
  }

  Widget _exist() {
    return Row(
      children: [
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Text(
                'Шығу',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.exit_to_app_outlined,
                color: Colors.white,
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }

  Widget _personalInf() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 30, right: 25),
            width: 110.0,
            height: 110.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.0),
                color: Colors.white),
            child: const Icon(Icons.person, size: 80.0, color: Colors.black)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text(
              _userController.userData.value!.fullname!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(_userController.userData.value!.email!),
            SizedBox(height: 5),
            Text('Номер телефона: ${_userController.userData.value!.number!}')
          ],
        )
      ],
    );
  }

  Widget _support() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _supportWidgets('Мои обьявления', Icons.shopping_bag, MyAds()),
          _supportWidgets('Настройки', Icons.settings, MyAds()),
          _supportWidgets('Помощник', Icons.support_agent, AIManager())
        ],
      ),
    );
  }

  Widget _supportWidgets(String _text, IconData _icon, Widget _page) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 80,
            height: 80,
            child: Icon(
              _icon,
              color: Colors.white,
              size: 35,
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3.0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
                color: Color(0xff7F86FF),
                borderRadius: BorderRadius.circular(15)),
          ),
          Text(_text)
        ],
      ),
      onTap: () => Get.to(_page),
    );
  }
}
