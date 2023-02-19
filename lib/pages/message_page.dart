import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/message_features/ai_manager.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../controllers/user_controller.dart';
import '../widgets/suggest_reg_page.dart';

class MessagePage extends StatelessWidget {
  UserController _userController = Get.find();
  MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _userController.userData.value == null
        ? SuggestRegPage()
        : _messages());
  }

  Widget _messages() {
    return SingleChildScrollView(
      child: Column(children: [_manager()]),
    );
  }

  Widget _manager() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/ChatGBT.jpeg'))),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI менеджер',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Я ваш искуственный менеджер')
              ],
            )
          ],
        ),
      ),
      onTap: () => Get.to(AIManager()),
    );
  }
}
