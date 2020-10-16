import 'dart:async';
import 'package:raid_organizer/model/event.dart';
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
    // Table Game
    await db.execute('''
    CREATE TABLE Game(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    image TEXT NULL,
    description TEXT NULL
    )
    ''');
    // Insertion de valeurs
    await db.rawInsert('''
    INSERT INTO Game(name, image, description) VALUES ("Dofus", "https://jolstatic.fr/www/captures/93/7/123967.png", "Dofus (prononcé /do.fousse/) est un jeu de rôle en ligne massivement multijoueur (MMORPG) français développé et édité par Ankama puis par sa filiale Ankama Games dès sa création en 2004.
Projet débuté par Emmanuel Darras, Camille Chafer et Anthony Roux, sa toute première version — qui proposait uniquement du joueur contre joueur — s'intitulait Arty Slot : Duel et était le quatrième opus de la série Arty Slot. De fil en aiguille les développeurs améliorent le jeu, pour en arriver à une phase de bêta-test et changent le nom du jeu en Dofus. Après quelques mois, Dofus sort le 1er septembre 2004 en France. Une version 2.0 sort en 2009, avec de nouveaux graphismes."
    )
    ''');
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
    CREATE TABLE Event(
      id INTEGER PRIMARY KEY,
      game TEXT NULL,
      date DATETIME NULL,
      description TEXT NULL,
      slots INT NULL,
      is_private BOOLEAN NULL,
      user INT
    )
    ''');
  }

  // CREATE
  // Fonction d'ajout des données dans Game
  Future<Game> addGame(Game game) async {
    Database myDatabase = await database;
    game.id = await myDatabase.insert('game', game.toMap());
    return game;
  }

  // Fonction d'ajout des données dans Event
  Future<Evenement> addEvent(Evenement evenement) async {
    Database myDatabase = await database;
    evenement.id = await myDatabase.insert('event', evenement.toMap());
    return evenement;
  }

  // UPDATE
  // Fonctions de modification des données Game
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

  // Fonction de modification des données Evenement
  Future<Evenement> upsertEvenement(Evenement evenement) async {
    Database myDatabase = await database;
    if (evenement.id == null) {
      evenement.id = await myDatabase.insert('event', evenement.toMap());
    } else {
      await myDatabase.update('event', evenement.toMap(),
          where: 'id = ?', whereArgs: [evenement.id]);
    }
    return evenement;
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
