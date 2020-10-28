import 'dart:async';
import 'package:flutter/material.dart';
import 'package:raid_organizer/model/event.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseClient extends ChangeNotifier {
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
    await db.rawInsert('''
    INSERT INTO Game(name, image, description) VALUES ("Fifa 21", "https://www.mega-pc.net/wp-content/uploads/2020/08/fifa-21-pre-order-gaming-tunisie.jpg", "FIFA 21 est un jeu vidéo de football développé par EA Canada et EA Roumanie et édité par EA Sports. La date de sortie du jeu, annoncée le 18 juin 2020, est prévue le 9 octobre 2020 sur PC, PlayStation 4, Xbox One et Nintendo Switch et plus tard sur PlayStation 5, Xbox Series et Stadia. Le jeu est également disponible à partir du 1er octobre pour les joueurs bénéficiant de l'EA Access ou de l'Origin Access. Trois versions différentes de cet opus sont disponibles : l'édition Standard, l'édition Champions et l'édition Ultimate. Il s'agit du vingt-huitième opus de la franchise FIFA développé par EA Sports.")
    ''');
    await db.rawInsert('''
    INSERT INTO Game(name, image, description) VALUES ("World Of Warcraft", "https://www.actugaming.net/wp-content/uploads/2019/08/world-of-warcraft-classic-1.jpg", "World of Warcraft /wɜrld.əv.wɔr.kræft/ (abrégé WoW) est un jeu vidéo de type MMORPG (jeu de rôle en ligne massivement multijoueur) développé par la société Blizzard Entertainment. C'est le 4e jeu de l'univers médiéval-fantastique Warcraft, introduit par Warcraft: Orcs and Humans en 1994. World of Warcraft prend place en Azeroth, près de quatre ans après les événements de la fin du jeu précédent, Warcraft III: The Frozen Throne (2003). Blizzard Entertainment annonce World of Warcraft le 2 septembre 2001. Le jeu est sorti en Amérique du Nord le 23 novembre 2004, pour les 10 ans de la franchise Warcraft.
La première extension du jeu, The Burning Crusade, est sortie le 16 janvier 2007. Depuis, sept extensions de plus ont été développées : Wrath of the Lich King, Cataclysm, Mists of Pandaria, Warlords of Draenor, Legion et Battle for Azeroth. Blizzard avait annoncé la sortie d'une nouvelle extension, Shadowlands, pour le 27 octobre 2020, mais cela a été repoussé.")
    ''');
    // Table User
    await db.execute('''
    CREATE TABLE User(
      id INTEGER PRIMARY KEY,
      username TEXT NOT NULL,
      mail TEXT NULL,
      image TEXT NULL,
      password TEXT NULL
    )
    ''');
    // Insertion de valeurs
    await db.rawInsert('''
    INSERT INTO User (username, mail, image, password) VALUES ("administrator", "admin@app.io", "https://backtowork.ch/wp-content/uploads/2020/05/user3.png", "password")
    ''');
    // Table Event
    // await db.execute('''
    // CREATE TABLE Event(
    //   id INTEGER PRIMARY KEY,
    //   game_id INT NULL,
    //   title TEXT NULL,
    //   date DATETIME NULL,
    //   description TEXT NULL,
    //   slots INT NULL,
    //   is_private BOOLEAN NULL,
    //   FOREIGN KEY (game_id) REFERENCES Game (id)
    // )
    // ''');
    await db.execute('''
    CREATE TABLE Event(
      id INTEGER PRIMARY KEY,
      title TEXT NULL,
      date DATETIME NULL,
      description TEXT NULL,
      slots INT NULL,
      is_private BOOL NULL
    )
    ''');
    // Insertion de valeurs
    // await db.rawInsert('''
    // INSERT INTO Event (game, date, description, slots, is_private) VALUES ("Donjon Piou", "admin@app.io", "https://backtowork.ch/wp-content/uploads/2020/05/user3.png", "admin")
    // ''');
  }

  // CREATE
  // Fonction d'ajout des données dans Game
  Future<Game> addGame(Game game) async {
    Database myDatabase = await database;
    game.id = await myDatabase.insert('game', game.toMap());
    return game;
  }

  // Fonction d'ajout des données dans Game
  Future<User> addUser(User user) async {
    Database myDatabase = await database;
    user.id = await myDatabase.insert('user', user.toMap());
    return user;
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
    notifyListeners();
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

  Future<List<User>> showUsers() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> result =
        await myDatabase.rawQuery("SELECT * FROM user");
    List<User> users = [];
    result.forEach((map) {
      User user = new User();
      user.fromMap(map);
      users.add(user);
    });
    return users;
  }

  Future<List<Evenement>> showEvents() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> result =
        await myDatabase.rawQuery("SELECT * FROM event");
    List<Evenement> events = [];
    result.forEach((map) {
      Evenement event = new Evenement();
      event.fromMap(map);
      events.add(event);
    });
    return events;
  }
}
