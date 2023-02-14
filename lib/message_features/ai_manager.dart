import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_everything/controllers/user_controller.dart';
import 'package:flutter_everything/moduls/message_module.dart';
import 'package:flutter_everything/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../widgets/message_view.dart';

class AIManager extends StatefulWidget {
  AIManager({super.key});

  @override
  State<AIManager> createState() => _AIManagerState();
}

class _AIManagerState extends State<AIManager> {
  UserController _userController = Get.find();

  TextEditingController _controller = TextEditingController();

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
      appBar: AppBar(
        title: Text('AI manager'),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: RemoteServices.getMessages(
                _userController.userData.value!, () => _update(), mounted),
            //initialData: [],
            builder: (context, snaphot) {
              return Column(
                children: [
                  Flexible(
                    child: snaphot.data != null
                        ? _messagesList(snaphot.data!)
                        : Container(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          //margin: EdgeInsets.only(bottom: 30, left: 30),
                          child: TextField(
                            decoration: InputDecoration(hintText: 'Сообщение'),
                            controller: _controller,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onTap: () async => _controller.text != ''
                            ? {
                                await RemoteServices.postMessage(MessageModule(
                                    question: _controller.text,
                                    user: _userController.userData.value!.id!)),
                                _controller.clear(),
                                //setState(() {})
                              }
                            : {Get.snackbar('Пусто', 'Напишите что нибудь')},
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _messagesList(List<MessageModule> messages) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MessageView(
                  title: messages[index].question,
                  color: Color(0xff7F86FF),
                ),
                MessageView(
                  title: messages[index].answer!.replaceAll('\n', ''),
                  color: Colors.green,
                ),
              ],
            ));
  }
}
