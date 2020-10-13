import 'dart:async';

import 'package:raid_organizer/model/game.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseClient {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      // Créer la database
      _database = await create();
      return _database;
    }
  }

  // Création de la base de données
  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'database.db');

    var bdd =
        await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  // Création des tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Game(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    )''');
    await db.execute('''
    CREATE TABLE User(
      id INTEGER PRIMARY KEY,
      username TEXT NOT NULL,
      mail TEXT NULL,
      image TEXT NULL,
      password TEXT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE Events(
      id INTEGER PRIMARY KEY,
      game TEXT NULL,
      description TEXT NULL,
      members INT NULL,
      
    )
    ''');
  }

  // Ajout des données
  Future<Game> addGame(Game game) async {
    Database myDatabase = await database;
    game.id = await myDatabase.insert('game', game.toMap());
    return game;
  }

  // Modification des données
  Future<int> updateGame(Game game) async {
    Database myDatabase = await database;
    return myDatabase
        .update('game', game.toMap(), where: 'id = ?', whereArgs: [game.id]);
  }

  Future<Game> upsertGame(Game game) async {
    Database myDatabase = await database;
    if (game.id == null) {
      game.id = await myDatabase.insert('game', game.toMap());
    } else {
      await myDatabase
          .update('game', game.toMap(), where: 'id = ?', whereArgs: [game.id]);
    }
    return game;
  }

  // Suppression des données
  Future<int> deleteGame(int id, String table) async {
    Database myDatabase = await database;
    return await myDatabase.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // Lecture des données
  Future<List<Game>> showGames() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> result =
        await myDatabase.rawQuery("SELECT * FROM game");
    List<Game> games = [];
    result.forEach((map) {
      Game game = new Game();
      game.fromMap(map);
      games.add(game);
    });
    return games;
  }
}
