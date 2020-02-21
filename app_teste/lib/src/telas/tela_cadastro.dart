import 'package:app_teste/src/bd_sqflite/bd_pauta.dart';
import 'package:app_teste/src/modelos/user_modelo.dart';
import 'package:app_teste/src/telas/tela_lista.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

/*
Para o cadastro de pautas foi utilizado o banco de dados Sqflite,
que está definido na pasta "bd_sqflite" na classe "bd_pauta".
*/
class PautaScreen extends StatefulWidget {

  final Page page;

  PautaScreen({this.page});

  @override
  _PautaScreenState createState() => _PautaScreenState();
}

class _PautaScreenState extends State<PautaScreen> {

  Page _editedPage;
  bool _userEdited = false;
   BdHelper helper = BdHelper();
   List<Page> pages = List();
   

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _detController = TextEditingController();
 


  final _namefocus = FocusNode();

  final _formKey = GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    

    if(widget.page == null){
      _editedPage = Page();
    }else{
      _editedPage = Page.fromMap(widget.page.toMap());
    }
  }

  void _resetField(){
    _editedPage = new Page();
     _nameController.text = "";
     _descController.text = "";
     _detController.text = "";
     
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Pauta"),
        centerTitle: true,
      ),
      body: Form(
       key: _formKey,
        child: ListView( 
          padding: EdgeInsets.all(12.0),          
          children: <Widget>[
            TextFormField(
               controller: _nameController,
              focusNode: _namefocus,
              decoration: InputDecoration(labelText: "Titulo",              
              ),
              validator: (text){
                if(text.isEmpty) return "Insira o Titulo";
              },
              onChanged: (text){
                _userEdited = true;
                
                  _editedPage.name = text;
               
              },
            ),
            TextFormField(
               controller: _descController,
              decoration: InputDecoration(labelText: "Descrição"),
              validator: (text){
                if(text.isEmpty) return "Insira a Descrição";
              },
              onChanged: (text){
                _userEdited = true;
               
                  _editedPage.desc = text;
               
              },
            ),
            TextFormField(
               controller: _detController,
              decoration: InputDecoration(labelText: "Detalhes"),
              validator: (text){
                if(text.isEmpty) return "Insira os Detalhes";
              },
              onChanged: (text){
                _userEdited = true;
              
                  _editedPage.det = text;
               
              },
            ),
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model){
                return Padding(
                  padding: EdgeInsets.only(top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Autor: ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                    style: TextStyle(fontSize: 16.0),                  
                    ),
                  ],
                ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                     await helper.savePauta(_editedPage);
                     await helper.updatePauta(_editedPage);                                 
                      _resetField();
                      
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> ListPauta())
                      );
                      
                    }
                  },
                  child: Text("Finalizar",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  ),
              ),
            )
          ],
        ),
     ),
    );
  }
}