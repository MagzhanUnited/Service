import 'package:flutter_everything/services/remote_services.dart';
import 'package:get/get.dart';

import '../moduls/product_module.dart';

class ProductsController extends GetxController {
  RxList<ProductModule> products = <ProductModule>[].obs;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    var _products = await RemoteServices.getProducts();
    if (products != null) {
      try {
        products = RxList.from(_products!);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
