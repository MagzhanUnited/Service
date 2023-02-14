import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:flutter_everything/widgets/product_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyAds extends StatefulWidget {
  MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  UserController _userController = Get.find();
  void _update() {
    try {
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: [],
        future: RemoteServices.getPersonalProduct(
            _userController.userData.value!.id!.toString(),
            () => _update(),
            mounted),
        builder: (context, snapshot) => Column(
          children: List.generate(
              snapshot.data!.length,
              (index) => Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ProductWidget(
                      person: _userController.userData.value,
                      iconDelete: Icons.delete,
                      productData: snapshot.data![index],
                      iconEdit: Icons.edit,
                    ),
                  )),
        ),
      ),
      appBar: AppBar(
        title: Text('Мой обьявления'),
      ),
    );
  }
}
