// import 'package:sqflite/sqflite.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

// class Database {
//   Database _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database;
//     } else {
//       // Créer la database
//     }
//   }

//   Future create() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String databaseDirectory = join(directory.path, 'database.db');

//     var bdd =
//         await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
//     return bdd;
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE Game(id INTEGER PRIMARY KEY, name TEXT NOT NULL, image TEXT NOT NULL, description TEXT NOT NULL)
//     ''');
//   }

//   // Ajout des données
// }
