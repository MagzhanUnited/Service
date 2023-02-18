import 'package:flutter/material.dart';
import 'package:flutter_everything/moduls/person_module.dart';
import 'package:flutter_everything/moduls/product_module.dart';

import '../services/remote_services.dart';

class DirectPage extends StatelessWidget {
  DirectPage({super.key, required this.product});
  ProductModule product;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RemoteServices.getPersonID(product.seller.toString()),
        builder: (context, snapshot) => snapshot.data != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data!.fullname!),
                ),
              )
            : Scaffold(
                body: CircularProgressIndicator(),
              ));
  }
}
