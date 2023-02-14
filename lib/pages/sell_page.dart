import 'package:flutter/material.dart';
import 'package:flutter_everything/controllers/product_controller.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/widgets/sell_tips.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../controllers/user_controller.dart';
import '../services/remote_services.dart';
import '../widgets/suggest_reg_page.dart';

class SellPage extends StatefulWidget {
  SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String _selectedOption1 = 'б/у';
  String _selectedOption2 = 'Нет';
  String _selectedOption3 = 'Машина';
  List<TextEditingController> _controller =
      List.generate(5, (index) => TextEditingController());

  UserController _userController = Get.find();
  ProductController _productController = Get.put(ProductController());
//RemoteServices
  List<String> _labels = [
    'картинка',
    'цена',
    'текст',
    'описание',
    'город',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _userController.userData.value == null ? SuggestRegPage() : _column());
  }

  Widget _page() {
    return Column(
      children: List.generate(
          5, (index) => _field(_labels[index], _controller[index])),
    );
  }

  Widget _column() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _page(),
          SellTips(
              first: 'б/у',
              second: 'новый',
              selectedOption: _selectedOption1,
              label: 'Состояния',
              func: (value) => setState(() => _selectedOption1 = value)),
          SellTips(
              first: 'Нет',
              second: 'Да',
              selectedOption: _selectedOption2,
              label: 'Доставка',
              func: (value) => setState(() => _selectedOption2 = value)),
          SellTips(
              first: 'Машина',
              second: 'Запчасть',
              third: 'Услуга',
              selectedOption: _selectedOption3,
              label: 'Тип',
              func: (value) => setState(() => _selectedOption3 = value)),
          _row_buttom(),
        ],
      ),
    );
  }

  Widget _row_buttom() {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        _buttom(),
        SizedBox(width: 35),
      ],
    );
  }

  Widget _buttom() {
    return GestureDetector(
      child: Container(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 40),
          child: Text(
            'Обьявить',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onTap: () => setState(() {
        _productController.prodactData.value = ProductModule(
          title: _controller[3].text,
          text: _controller[2].text,
          price: _controller[1].text,
          image: _controller[0].text,
          isDeliver: _selectedOption2,
          states: _selectedOption1,
          city: _controller[4].text,
          seller: _userController.userData.value!.id!,
          cartype: _selectedOption3,
        );
        for (TextEditingController e in _controller) {
          e.clear();
        }
        RemoteServices.postProduct(_productController.prodactData.value!);
      }),
    );
  }

  Widget _field(String _label, TextEditingController _controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: _label),
      ),
    );
  }
}
