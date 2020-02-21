import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String pautatable = "pautatable";
final String idCol = "idColumn";
final String nameCol = "nameColumn";
final String descCol = "descColumn";
final String detCol = "detColumn";


class BdHelper{
  static final BdHelper _instance = BdHelper.internal();

  factory BdHelper() => _instance;

  BdHelper.internal();

   Database _db;

   Future<Database> get db async{
      if(_db != null){
        return _db;
      }else{
        _db = await initDb();
        return _db;
      }
    }

    Future<Database>initDb() async{ //inicia banco de dados
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "pautasnew.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
    await db.execute("CREATE TABLE $pautatable($idCol INTEGER PRIMARY KEY AUTOINCREMENT, $nameCol TEXT, $descCol TEXT,"
    "$detCol TEXT)",
    );
  });
}

Future<Page> savePauta(Page page) async{ //salvar dados
  Database dbPauta = await db;
  page.id = await dbPauta.insert(pautatable, page.toMap());
  return page;
}

Future<Page> getPauta(int id) async{ //obter dados
   Database dbPauta = await db;
   List<Map> maps = await dbPauta.query(pautatable,
   columns: [idCol, nameCol, descCol, detCol],
   where: "$idCol = ?",
   whereArgs: [id]);
   if(maps.length > 0){
     return Page.fromMap(maps.first);
   }else{
     return null;
   }
}

Future<int> deletePauta(int id) async{ //deletar dados
  Database dbPauta = await db;
  return await dbPauta.delete(pautatable, where: "$idCol = ?", whereArgs: [id]);
}

Future<int> updatePauta(Page page) async{ //atualizar dados
  Database dbPauta = await db;
  return await dbPauta.update(pautatable,
   page.toMap(), 
   where: "$idCol = ?", 
   whereArgs: [page.id]);
}

Future<List> getAllPautas() async{ //obter lista de todos os dados
  Database dbPauta = await db;
  List listMap = await dbPauta.rawQuery("SELECT * FROM $pautatable");
  List<Page> listPauta = List();
  for(Map m in listMap){
    listPauta.add(Page.fromMap(m));
  }
  return listPauta;
}

Future<int> getNumber() async{ //retorna a quantidade de dados
  Database dbPauta = await db;
  return Sqflite.firstIntValue(await dbPauta.rawQuery("SELECT COUNT(*) FROM $pautatable"));
}

 Future close() async{ //encerra o banco de dados
  Database dbPauta = await db; 
  dbPauta.close();
}



}

class Page{

  int id;
  String name;
  String desc;
  String det;
  

  Page();

  Page.fromMap(Map map){
    id = map[idCol];
    name = map[nameCol];
    desc = map[descCol];
    det = map[detCol];
    

  }

  Map toMap(){
    Map<String, dynamic> map = {
      nameCol:  name,
      descCol:  desc,
      detCol: det
      

    };
    if(id != null){
      map[idCol] = id;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Page(id: $id, name: $name, descricao: $desc, detalhe: $det)";
  }
}