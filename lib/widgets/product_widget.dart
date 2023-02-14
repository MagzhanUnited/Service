import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/inner_pages/main_inner_page.dart';
import 'package:flutter_everything/inner_pages/personal_inners/edit_page.dart';
import 'package:flutter_everything/moduls/person_module.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:flutter_everything/my_flutter_app_icons.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class ProductWidget extends StatefulWidget {
  ProductModule productData;
  IconData? iconDelete;
  IconData? iconEdit;
  PersonModule? person;
  ProductWidget(
      {super.key,
      this.iconDelete,
      required this.productData,
      this.person,
      this.iconEdit});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(3.0, 3.0),
            ),
          ], color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          //height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleRow(widget.productData.title!),
              const SizedBox(height: 10),
              _priceNumber(widget.productData.price!),
              const SizedBox(height: 10),
              _mainBody(widget.productData.text!),
              SizedBox(height: 10),
              _views()
            ],
          ),
        ),
        onTap: () {
          Get.to(MainInnerPage(
            productData: widget.productData,
          ));
          if (widget.person != null) {
            RemoteServices.updateView(widget.productData.id!, widget.person!);
          }
        });
  }

  Widget _views() {
    return Row(
      children: [
        Icon(Icons.remove_red_eye),
        SizedBox(
          width: 10,
        ),
        Text(widget.productData.views!.length.toString()),
        SizedBox(width: 50),
        Icon(
          NewIcons.heart,
          color: Colors.red,
        ),
        SizedBox(width: 10),
        Text(widget.productData.likes!.length.toString())
      ],
    );
  }

  Widget _titleRow(String _title) {
    return Row(
      children: [
        Text(
          _title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
            onPressed: () => Get.to(EditPage()), icon: Icon(widget.iconEdit)),
        const SizedBox(width: 10),
        GestureDetector(
            child: Icon(widget.iconDelete),
            onTap: () {
              Get.defaultDialog(
                  title: 'Вы уверены что хотите удалить?',
                  content: Container(),
                  textConfirm: 'Да',
                  textCancel: 'Нет',
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    await _func();
                    setState(() {});
                  });
            }),
        const SizedBox(width: 15),
        widget.person != null
            ? FutureBuilder(
                initialData: PersonModule(),
                future: RemoteServices.getPerson(
                    widget.person!.email!, widget.person!.password!),
                builder: (context, snapshot) => IconButton(
                    onPressed: () async {
                      if (widget.person != null) {
                        await RemoteServices.update(
                            widget.productData.id!, snapshot.data!);
                        //snapshot.data = await RemoteServices.getPerson(
                        //  widget.person!.email!, widget.person!.password!);
                        //await RemoteServices.getProduct(widget.person!.id!);
                        print(widget.person!.liked);
                      } else {
                        Get.snackbar('авторизуйтесь', 'Если хотите сохранить');
                      }
                      setState(() {});
                    },
                    icon: snapshot.data!.liked != null
                        ? snapshot.data!.liked!.contains(widget.productData.id!)
                            ? Icon(
                                NewIcons.heart,
                                color: Colors.red,
                              )
                            : Icon(NewIcons.heart_empty)
                        : Icon(NewIcons.heart_empty)),
              )
            : Icon(NewIcons.heart_empty),
        const SizedBox(width: 30)
      ],
    );
  }

  _textWidget(String title) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xff7F86FF), borderRadius: BorderRadius.circular(15)),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _func() async {
    await RemoteServices.deleteProduct(widget.productData.id!.toString());
  }

  Widget _priceNumber(String _price) {
    return Text(
      _price,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _mainBody(String _text) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.productData.image!)),
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          //color: Colors.blue,
          padding: const EdgeInsets.all(15),
          width: 230,
          height: 150,
          child: Text(
            _text,
            maxLines: 6,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
