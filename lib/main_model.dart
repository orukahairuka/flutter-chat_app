import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//viewとmodelの橋渡しする
final mainProvider = ChangeNotifierProvider(((ref) => MainModel()));

class MainModel extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
