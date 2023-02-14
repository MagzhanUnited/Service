import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/liked_product_controller.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:flutter_everything/widgets/product_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/suggest_reg_page.dart';

class HeartPage extends StatelessWidget {
  UserController _userController = Get.find();
  HeartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _userController.userData.value == null ? SuggestRegPage() : _column());
  }

  Widget _column() {
    return FutureBuilder(
        initialData: [],
        future: RemoteServices.getProduct(_userController.userData.value!.id!),
        builder: (context, snapshot) => SingleChildScrollView(
              child: Column(
                children: List.generate(
                    snapshot.data!.length,
                    (index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: ProductWidget(
                              productData: snapshot.data![index]!,
                              person: _userController.userData.value),
                        )),
              ),
            ));
  }
}
