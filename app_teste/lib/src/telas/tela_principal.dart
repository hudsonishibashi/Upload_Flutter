import 'package:app_teste/src/drawers/drawer_personalizado.dart';
import 'package:app_teste/src/telas/navegar_tela.dart';
import 'package:app_teste/src/telas/tela_perfil.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController();
 
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
      appBar: AppBar(
        title: Text("Bem Vindo ao app",
        style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        
      ),
      body: Container(
        color: Color.fromARGB(255, 22, 117, 185),
        child: Stack(
        children: <Widget>[
          Image.asset("images/homeuds1.jpg",
            fit: BoxFit.fitWidth,
            height: 500,
            ),
        ],
      ),
      ), 
     
      drawer: CustomDrawer(_pageController),      
      ),   
      Container(
        child: PerfilScreen(),
      )   
      ],
    );
  } 
}