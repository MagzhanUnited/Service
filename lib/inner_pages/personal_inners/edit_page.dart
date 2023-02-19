import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/sell_tips.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<TextEditingController> _textControllers =
      List.generate(5, (_) => TextEditingController());

  List<String> _labels = ['Описание', 'Текст', 'Город', 'Картинка', 'Цена'];
  String _selectedOption1 = 'б/у';
  String _selectedOption2 = 'Нет';
  String _selectedOption3 = 'Машина';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Изменить')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_editingThings(), _includeThings(), _buttom()],
            ),
          ),
        ));
  }

  Widget _textFields(TextEditingController _textController, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: TextField(
        controller: _textController,
        minLines: 3,
        maxLines: 5,
        decoration:
            InputDecoration(label: Text(label), border: InputBorder.none),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey[300]!)),
    );
  }

  Widget _editingThings() {
    return Column(
      children: List.generate(
          5, (index) => _textFields(_textControllers[index], _labels[index])),
    );
  }

  Widget _includeThings() {
    return Column(
      children: [
        SellTips(
            first: 'б/у',
            second: 'новый',
            selectedOption: _selectedOption1,
            label: 'Состояния',
            func: (value) => setState(() => _selectedOption1 = value)),
        SellTips(
            first: 'Нет',
            second: 'Да',
            selectedOption: _selectedOption2,
            label: 'Доставка',
            func: (value) => setState(() => _selectedOption2 = value)),
        SellTips(
            first: 'Машина',
            second: 'Запчасть',
            third: 'Услуга',
            selectedOption: _selectedOption3,
            label: 'Тип',
            func: (value) => setState(() => _selectedOption3 = value)),
      ],
    );
  }

  Widget _buttom() {
    return Row(
      children: [
        Expanded(child: Container()),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              'Изменить',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          ),
        )
      ],
    );
  }
}
