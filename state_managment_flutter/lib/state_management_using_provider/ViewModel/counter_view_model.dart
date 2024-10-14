import 'package:flutter/material.dart';
import '../Model/item_model.dart';
import 'dart:math';

class CounterViewModel extends ChangeNotifier {
  List<int> listOfNumber = [1, 2, 3];
  List<Item> listOfItem = [];

  addNewElementInList() {
    final lastElement = listOfNumber.last;
    listOfNumber.add(lastElement + 1);
    notifyListeners();
  }

  addNewItem() {
    listOfItem.add(Item(name: generateRandomString(10)));
  }


  String generateRandomString(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
  }

}


