import 'package:app_teste/src/modelos/user_modelo.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PerfilScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nome: ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                   style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold
                          ),
               ),
               
               Divider(),
               SizedBox(height: 5.0,),
                Text("E-mail: ${!model.isLoggedIn() ? "" : model.userData["email"]}",
                   style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold
                          ),
               ),
              ],
            );
          }
          ),
      ),
    );
  }
}