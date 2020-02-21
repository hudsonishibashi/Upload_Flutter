import 'package:app_teste/src/modelos/user_modelo.dart';
import 'package:app_teste/src/telas/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
      title: 'App Teste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 22, 117, 210)
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      ),
    );
  }
}

