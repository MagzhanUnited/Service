import 'dart:convert';

import 'package:flutter_everything/moduls/person_module.dart';

ProductModule productModuleFromJson(String str) =>
    ProductModule.fromJson(json.decode(str));

String productModuleToJson(ProductModule data) => json.encode(data.toJson());

List<ProductModule> productsModuleFromJson(String str) =>
    List<ProductModule>.from(
        json.decode(str).map((x) => ProductModule.fromJson(x)));

String productsModuleToJson(List<ProductModule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModule {
  ProductModule({
    this.id,
    this.title,
    this.text,
    this.price,
    this.image,
    this.states,
    this.city,
    this.isDeliver,
    this.cartype,
    this.seller,
    this.likes,
    this.views,
  });

  int? id;
  String? title;
  String? text;
  String? price;
  String? image;
  String? states;
  String? city;
  String? isDeliver;
  String? cartype;
  int? seller;
  List<int>? likes;
  List<int>? views;

  factory ProductModule.fromJson(Map<String, dynamic> json) => ProductModule(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        price: json["price"],
        image: json["image"],
        states: json["states"],
        city: json["city"],
        isDeliver: json["isDeliver"],
        cartype: json["cartype"],
        seller: json["seller"],
        likes: List<int>.from(json["likes"].map((x) => x)),
        views: List<int>.from(json["views"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "price": price,
        "image": image,
        "states": states,
        "city": city,
        "isDeliver": isDeliver,
        "cartype": cartype,
        "seller": seller,
        "likes":
            likes != null ? List<dynamic>.from(likes!.map((x) => x)) : null,
        "views":
            views != null ? List<dynamic>.from(views!.map((x) => x)) : null,
      };
}
