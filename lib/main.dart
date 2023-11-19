import 'package:chat_app/models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    //テキストエディティングコントローラー型のインスタンス生成
    // final TextEditingController emailEditingController =
    //     TextEditingController(text: mainModel.email);
    // final TextEditingController passwordEditingController =
    //     TextEditingController(text: mainModel.password);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(child: Icon(Icons.person),),
            InkWell(child: Icon(Icons.person),),
            //テキストフォームフィールド(email)
            // TextFormField(
            //   keyboardType: TextInputType.emailAddress,
            //   controller: emailEditingController,
            //   onChanged: (text) => mainModel.email = text, //押されるとされる処理
            // ),
            // //テキストフォームフィールド(pass)
            // TextFormField(
            //   keyboardType: TextInputType.visiblePassword,
            //   controller: passwordEditingController,
            //   onChanged: (text) => mainModel.password = text, //押されるとされる処理
            //   obscureText: mainModel.isObscure,
            //   decoration: InputDecoration(
            //     //アイコンをタップできるようにする
            //     suffix: InkWell(
            //       child: const Icon(Icons.visibility_off),
            //       onTap: () => mainModel.toggleIsObscure(),
            //     ),
            //   ),
            // ),
            // //nullかnullじゃないかの表示
            // Center(
            //   child: mainModel.currentUser == null
            //       ? const Text('Nullです')
            //       : const Text('Nullじゃないです'),
            // ),
            Text('Nullです'),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => mainModel.createUser(context: context),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
