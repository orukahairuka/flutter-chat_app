import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/domain/firestore_user/firestore_user.dart';

//viewとmodelの橋渡しする
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel(),
);


class MainModel extends ChangeNotifier {
  int counter = 0;
  User? currentUser;
  String email = "";
  String password = "";
  bool isObscure = true;//textを隠すかどうか

//firebase Firestoreに新しいユーザーを作成する
  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    // final String v4 = uuid.v4();
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      email: email,
      uid: uid,
      userName: 'Alice',
      updatedAt: now,
      createdAt: now,
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();

    //awaitで順次実行する
    await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
    //処理が終わったことを知らせるメッセージ表示する
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user; //userオブジェクトを取得,user情報
      final String uid = user!.uid; //取得したuserオブジェクトからuidを得る,ユーザーの一意のID

      await createFirestoreUser(context: context, uid: uid);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
