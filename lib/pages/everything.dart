import 'package:flutter/material.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/widgets/bar_widgets.dart';
import 'package:flutter_everything/widgets/product_widget.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../controllers/user_controller.dart';

class Everything extends StatelessWidget {
  ProductsController _productController = Get.find();
  UserController _userController = Get.find();
  Everything({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snaphot) => _page(),
        future: _productController.fetchProduct());
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [_row(), _column()],
        ),
      ),
    );
  }

  Widget _row() {
    return Row(
      children: [
        BarWidgets(
            icon: Icons.directions_car, title: 'Машины', func: () => func()),
        BarWidgets(
            icon: Icons.cases_outlined, title: 'запчасти', func: () => func()),
        BarWidgets(
            icon: Icons.credit_card, title: 'Сервисы', func: () => func()),
        BarWidgets(
            icon: Icons.directions_boat, title: 'Прочее', func: () => func())
      ],
    );
  }

  void func() {
    print('object');
  }

  Widget _column() {
    return Obx(() => Column(
          children: List.generate(
              _productController.products.value.length,
              (index) =>
                  Obx(() => _products(_productController.products[index]))),
        ));
  }

  Widget _products(ProductModule productModule) {
    return Column(
      children: [
        SizedBox(height: 20),
        Obx(() => ProductWidget(
              person: _userController.userData.value,
              productData: productModule,
            ))
      ],
    );
  }
}
