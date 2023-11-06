import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/data.dart';

//viewとmodelの橋渡しする
final mainProvider = ChangeNotifierProvider(((ref) => MainModel()));
final uuid = Uuid();

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> createUser({required BuildContext context}) async {
    counter++;
    final v4 = uuid.v4();
    final Map<String, dynamic> userData = {
      'userName': 'Alice',
      'uid': v4,
    };
    //awaitで順次実行する
    await FirebaseFirestore.instance
        .collection('users')
        .doc('firstUser')
        .set(userData);
    //処理が終わったことを知らせるメッセージ表示する
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }
}
