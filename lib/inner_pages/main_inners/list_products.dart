import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/widgets/product_widget.dart';

class ListProducts extends StatelessWidget {
  ListProducts({super.key, required this.cars});
  List<ProductModule> cars;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Машины'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                cars.length,
                (index) => Container(
                      child: ProductWidget(productData: cars[index]),
                      margin: EdgeInsets.symmetric(vertical: 10),
                    )),
          ),
        ),
      ),
    );
  }
}
