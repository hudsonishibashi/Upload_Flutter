import 'package:app_teste/src/drawers/drawer_padrao.dart';
import 'package:app_teste/src/modelos/user_modelo.dart';
import 'package:app_teste/src/telas/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset("images/logouds.png"),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Ola, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                          style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold
                          ),
                          ),
                          GestureDetector( 
                            child: Text(                                                     
                               "Sair",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor, 
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            onTap: (){
                              if(model.isLoggedIn())
                              Navigator.of(context).pushReplacement( 
                                MaterialPageRoute(builder: (context)=>LoginScreen())
                              );
                            },
                          )
                        ],
                      );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(), 
              DrawerTile(Icons.home, "Inicio", pageController, 0),
            ],
          )
        ],
      ),
    );
  }
}
