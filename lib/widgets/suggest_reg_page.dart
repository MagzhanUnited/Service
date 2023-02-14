import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/inner_pages/auth_inner_page.dart';
import 'package:flutter_everything/inner_pages/reg_inner_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class SuggestRegPage extends StatelessWidget {
  const SuggestRegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_reg('Войти'), _reg('Регестрация')],
      )),
    );
  }

  Widget _reg(
    String _title,
  ) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        child: Text(
          _title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      ),
      onTap: () => Get.to(_title == 'Войти' ? AuthInnerPage() : RegInnerPage()),
    );
  }
}
