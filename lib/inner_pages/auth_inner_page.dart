import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/moduls/person_module.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthInnerPage extends StatefulWidget {
  AuthInnerPage({super.key});

  @override
  State<AuthInnerPage> createState() => _AuthInnerPageState();
}

class _AuthInnerPageState extends State<AuthInnerPage> {
  List<TextEditingController> _controller =
      List.generate(2, (index) => TextEditingController());
  UserController _userController = Get.find();

  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _field('email', _controller[0]),
          _field('password', _controller[1]),
          _buttom()
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
      title: Text('Авторизация'),
    );
  }

  Widget _field(String _label, TextEditingController _controller) {
    bool isPassword = _label == 'password';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: TextField(
        obscureText: isPassword,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        controller: _controller,
        decoration: InputDecoration(labelText: _label),
      ),
    );
  }

  Widget _buttom() {
    return GestureDetector(
      child: Container(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 40),
          child: Text(
            'Подтвердить',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onTap: () async {
        try {
          _userController.userData.value = (await RemoteServices.getPerson(
              _controller[0].text, _controller[1].text))!;
          Get.back();
        } catch (e) {
          Get.snackbar(
              'Проблема с Интернетом', 'или неверный логин или пороль');
        }
        for (TextEditingController e in _controller) {
          e.clear();
        }
      },
    );
  }
}
