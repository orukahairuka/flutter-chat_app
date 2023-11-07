import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:chat_app/domain/firestore_user/firestore_user.dart';

//viewとmodelの橋渡しする
final mainProvider = ChangeNotifierProvider(((ref) => MainModel()));
final uuid = Uuid();

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> createUser({required BuildContext context}) async {
    counter++;
    final String v4 = uuid.v4();
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser =
        FirestoreUser(
          uid: v4,
          userName: 'Alice',
          updatedAt: now,
          createdAt: now,
          );
    final Map<String, dynamic> userData = firestoreUser.toJson();

    //awaitで順次実行する
    await FirebaseFirestore.instance.collection('users').doc().set(userData);
    //処理が終わったことを知らせるメッセージ表示する
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }
}
