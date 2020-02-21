import 'package:app_teste/src/telas/tela_cadastro.dart';
import 'package:app_teste/src/telas/tela_lista.dart';
import 'package:app_teste/src/telas/tela_perfil.dart';
import 'package:app_teste/src/telas/tela_principal.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {

  PageController _pageController; 
  int page = 0;

  @override
  void initState(){
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white70)
          )
        ),
        child:  BottomNavigationBar(
          currentIndex: page,
          onTap: (p){
            _pageController.animateToPage(p, duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Inicio")
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text("Inserir")
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Lista")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text("Perfil")
          ),
        ],
      ),
      ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (p){
            setState(() {
              page = p;
            });
          },
        children: <Widget>[
            HomeScreen(),                 
            PautaScreen(), 
            Container(
            child: ListPauta(),
            ),                 
            PerfilScreen(),        
        ],
      ),
    );
  }
}