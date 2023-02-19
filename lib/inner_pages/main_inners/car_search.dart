import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/inner_pages/main_inners/list_products.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:flutter_everything/widgets/product_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../moduls/product_module.dart';

class CarSearch extends StatefulWidget {
  const CarSearch({super.key});

  @override
  State<CarSearch> createState() => _CarSearchState();
}

class _CarSearchState extends State<CarSearch> {
  List<ProductModule>? _list = [];
  _onChanged(String value) async {
    _list = await RemoteServices.searchingProduct('Машина', value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Машины'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              onChanged: (value) async => await _onChanged(value),
              decoration: InputDecoration(
                  label: Text('Текст продукта'),
                  suffixIcon: Icon(Icons.search)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Цена',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  //margin: EdgeInsets.only(left: 25),
                  child: TextField(
                    decoration: InputDecoration(label: Text('Минимум')),
                  ),
                ),
                Container(
                  width: 150,
                  //margin: EdgeInsets.only(right: 25),
                  child: TextField(
                    decoration: InputDecoration(label: Text('Максимум')),
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                width: double.maxFinite,
                child: Center(
                    child: Text(
                  '${_list == null ? 0 : _list!.length} результатов',
                  style: TextStyle(color: Colors.white),
                )),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
              ),
              onTap: () => Get.to(ListProducts(cars: _list!)),
            )
          ]),
        ),
      ),
    );
  }
  /*FutureBuilder(
                initialData: [],
                future: RemoteServices.chosenProduct('Машина'),
                builder: (contex, snaphot) {
                  return snaphot.data != null
                      ? Column(
                          children: List.generate(
                              snaphot.data!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: ProductWidget(
                                        productData: snaphot.data![index]),
                                  )),
                        )
                      : const CircularProgressIndicator();
                }) */
}
