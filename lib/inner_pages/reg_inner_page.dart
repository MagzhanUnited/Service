import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/moduls/person_module.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegInnerPage extends StatefulWidget {
  RegInnerPage({super.key});

  @override
  State<RegInnerPage> createState() => _RegInnerPageState();
}

class _RegInnerPageState extends State<RegInnerPage> {
  List<TextEditingController> controller =
      List.generate(4, (index) => TextEditingController());
  UserController _userController = Get.find();

  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _field('email', controller[0]),
          _field('password', controller[1]),
          _field('number', controller[2]),
          _field('fullname', controller[3]),
          _buttom()
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
      title: Text('Регестрация'),
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
            'Регестрироваться',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onTap: () async {
        return await _func();
      },
    );
  }

  Future<void> _func() async {
    setState(() {
      _userController.userData.value = PersonModule(
          email: controller[0].text,
          password: controller[1].text,
          number: controller[2].text,
          fullname: controller[3].text);

      for (TextEditingController e in controller) {
        e.clear();
      }
    });
    try {
      await RemoteServices.postPerson(_userController.userData.value!);
      _userController.userData.value!.id = (await RemoteServices.getPerson(
              _userController.userData.value!.email!,
              _userController.userData.value!.password!))!
          .id;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Проблема с интернетом', 'Проверьте подключение');
      _userController.userData.value = null;
    }
  }
}
