import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_everything/context_size.dart';
import 'package:flutter_everything/inner_pages/main_inner_page.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:flutter_everything/widgets/bar_widgets.dart';
import 'package:flutter_everything/widgets/product_widget.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../controllers/user_controller.dart';

class Everything extends StatefulWidget {
  Everything({super.key});

  @override
  State<Everything> createState() => _EverythingState();
}

class _EverythingState extends State<Everything> {
  ProductsController _productController = Get.find();

  UserController _userController = Get.find();
  var _currPageValue = 0.0;
  double _scaleFacttor = 0.8;
  double _height = ContextSize.height;
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snaphot) => _page(),
        future: _productController.fetchProduct());
  }

  Widget _page() {
    return RefreshIndicator(
      onRefresh: () async => await Future.delayed(Duration(seconds: 1))
          .then((value) => setState(() {})),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _row(),
              _popularProducts(),
              _column(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularProducts() {
    return FutureBuilder(
      initialData: [],
      future: RemoteServices.bestProducts(),
      builder: (context, snapshot) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              'Популярные и новинки',
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 40),
            height: ContextSize.height * 0.3,
            child: snapshot.data == null
                ? Container()
                : PageView.builder(
                    controller: pageController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPageItem(index, snapshot.data![index]);
                    },
                  ),
          ),
          _dots(snapshot.data!.length),
        ],
      ),
    );
  }

  Widget _dots(int length) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DotsIndicator(
        dotsCount: length == 0 ? 1 : length,
        position: _currPageValue,
        decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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

  Widget _buildPageItem(int position, ProductModule popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (position == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFacttor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFacttor + (_currPageValue - position + 1) * (1 - _scaleFacttor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFacttor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFacttor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: (() {
            Get.to((MainInnerPage(
              productData: popularProduct,
            )));
          }),
          child: Container(
            height: _height,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 90),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF69c5df),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(popularProduct.image!))),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            margin: EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ]),
            child: Container(
              padding: EdgeInsets.only(
                top: 15, /* left: 15, right: 15*/
              ),
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          'New',
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      SizedBox(width: 35),
                      Text(
                        popularProduct.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: List.generate(
                        5,
                        (index) => Container(
                              margin: EdgeInsets.only(right: 5, bottom: 10),
                              child: Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.blue,
                              ),
                            )),
                  ),
                  Container(
                    child: Text(
                      'Цена: ${popularProduct.price!} тг',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
