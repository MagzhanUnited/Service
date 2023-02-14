import 'package:flutter_everything/moduls/message_module.dart';
import 'package:flutter_everything/moduls/person_module.dart';
import 'package:flutter_everything/moduls/product_module.dart';
import 'package:get/get.dart';

class RemoteServices extends GetConnect {
  static var client = GetConnect();
  static String? _baseUrl = 'http://127.0.0.1:8000';
  static Future<void> postPerson(PersonModule data) async {
    await client.post('${_baseUrl}/create/person/', personModuleToJson(data));
  }

  static Future<PersonModule?> getPerson(
      String _email, String _password) async {
    var response =
        await client.get('${_baseUrl}/getPerson/${_email}/${_password}/');
    if (response.statusCode == 200) {
      return personModuleFromJson(response.bodyString!);
    } else {
      return null;
    }
  }

  static Future<void> postProduct(ProductModule data) async {
    await client.post('${_baseUrl}/create/product/', productModuleToJson(data));
  }

  static Future<List<ProductModule>?> getProducts() async {
    var response = await client.get('${_baseUrl}/getProducts/');
    if (response.statusCode == 200) {
      return productsModuleFromJson(response.bodyString!);
    } else {
      return null;
    }
  }

  static Future<PersonModule?> getPersonID(String id) async {
    var response = await client.get('${_baseUrl}/getPersonID/${id}/');
    if (response.statusCode == 200) {
      return personModuleFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<List<ProductModule>?> getPersonalProduct(
      String id, Function function, bool mounted) async {
    var response = await client.get('${_baseUrl}/getPersonalProducts/${id}/');
    if (response.statusCode == 200) {
      if (mounted) {
        function();
      }
      return productsModuleFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<void> deleteProduct(String id) async {
    await client.delete('${_baseUrl}/deleteProduct/${id}/');
  }

  static Future<bool> update(int pk, PersonModule body) async {
    var response = await client.put(
        '${_baseUrl}/update/likes/${pk}/', personModuleToJson(body));
    if (response.statusCode == 200) {
      //print('updated');
      return true;
    } else {
      //print('isnt updated');
      return false;
    }
  }

  static Future<void> updateView(int pk, PersonModule body) async {
    var response = await client.put(
        '${_baseUrl}/update/views/${pk}/', personModuleToJson(body));
    if (response.statusCode == 200) {
      print('updated');
    } else {
      print('isnt updated');
    }
  }

  static Future<List<ProductModule>?> getProduct(int id) async {
    var response = await client.get('$_baseUrl/getProduct/$id/');
    if (response.statusCode == 200) {
      //print(productsModuleFromJson(response.bodyString!));
      return productsModuleFromJson(response.bodyString!);
    } else {
      return null;
    }
  }

  static Future<void> postMessage(MessageModule data) async {
    await client.post('$_baseUrl/postMessage/', messageModuleToJson(data));
  }

  static Future<List<MessageModule>?> getMessages(
      PersonModule person, Function function, bool mounted) async {
    var response = await client.get('$_baseUrl/getMessages/${person.id}/');
    if (response.statusCode == 200) {
      //print(messagesModuleFromJson(response.bodyString!)[0].answer);
      if (mounted) {
        function();
      }
      return messagesModuleFromJson(response.bodyString!);
    }
    return null;
  }
}
