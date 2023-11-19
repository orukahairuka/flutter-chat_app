import 'package:chat_app/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/models/signup_model.dart';


class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    //テキストエディティングコントローラー型のインスタンス生成
    final TextEditingController emailEditingController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);

    return Scaffold(
      appBar: AppBar(
        title: const Text("サインアップ"),
      ),
      body: Column(
        children: [
          //テキストフォームフィールド(email)
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            onChanged: (text) => signupModel.email = text, //押されるとされる処理
          ),
          //テキストフォームフィールド(pass)
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordEditingController,
            onChanged: (text) => signupModel.password = text, //押されるとされる処理
            obscureText: signupModel.isObscure,
            decoration: InputDecoration(
              //アイコンをタップできるようにする
              suffix: 
              InkWell(
                child: const Icon(Icons.visibility_off),
                onTap: () => signupModel.toggleIsObscure(),
              ),
            ),
          ),
          //nullかnullじゃないかの表示
          Center(
            child: signupModel.currentUser == null
                ? const Text('Nullです')
                : const Text('Nullじゃないです'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signupModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
