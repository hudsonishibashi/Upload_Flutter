import 'package:app_teste/src/bd_sqflite/bd_pauta.dart';
import 'package:app_teste/src/modelos/user_modelo.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


/*
A lista com as pautas foram buscadas através do banco criado no Sqflite.
*/

class ListPauta extends StatefulWidget {
  @override
  _ListPautaState createState() => _ListPautaState();
}

class _ListPautaState extends State<ListPauta> {

  BdHelper helper = BdHelper();

  List<Page> pages = List();

  @override
  void initState(){
    super.initState();
    _getAllPautas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Pautas"),
        centerTitle: true,
      ),
      body: Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index){
          return _card(context, index);
        }
        ),
    )
    );
    
  }

  void _getAllPautas(){
    helper.getAllPautas().then((list){
      setState(() {
        pages = list;
      });
    });
  }

  Widget _card(BuildContext context, int index){
    String _status = "Aberto";
     return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(_status,
          style: TextStyle(color: Colors.green),
          ),
          trailing: Text("Titulo:\n ${pages[index].name?? ""}"), 
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("Titulo: ${pages[index].name?? ""}",
                        style: TextStyle(fontSize: 16.0)),
                        subtitle: Text("Descrição: ${pages[index].desc??""}",
                        ), 
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        title: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Autor: ${!model.isLoggedIn() ? "" : model.userData["name"]}"
                                )
                              ],
                            );
                          }
                          ),
                          contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       FlatButton(
                        onPressed: (){
                        _showDialog(context, index);
                        },
                        textColor: Colors.red,
                         child: Text("Excluir"),
                         ),
                          FlatButton(
                        onPressed: (){
                         setState(() {
                           _status = "Aberto";
                           
                         });
                        },
                        textColor: Colors.black,
                         child: Text("Reabrir"),
                         ),
                      FlatButton(
                        onPressed: (){
                         setState(() {                                                    
                         });
                        },
                        textColor: Colors.green,
                         child: Text("Finalizar"),
                         )
                    ],
                  )
                ],
              ),
            )
          ],
           ),
      ),
    );
  }

  _showDialog(context, index){
    showDialog(
        context: context,
        builder: (context){
     return AlertDialog(
         title: Text("Excluir?"),
            content: Text("Tem certeza que deseja excluir?"),
             actions: <Widget>[
               FlatButton(
               child: Text("Cancelar"),
                 onPressed: (){
                     Navigator.pop(context);
                   },
               ),
               FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                  helper.deletePauta(pages[index].id);
                  setState(() {
                  pages.removeAt(index);
               Navigator.pop(context);
               });
            },
          )
        ],
       );
     }
   );
  }
}

