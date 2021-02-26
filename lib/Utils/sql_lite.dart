import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_first_project/Models/user_history.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void SQLite() async {

  final Future<Database> database = openDatabase(

    join(await getDatabasesPath(), 'history.db'),

    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)",
      );
    },
    version: 1,
  );

  Future<void> insertUser(UserHistory user) async {

    final Database db = await database;

    await db.insert(
      'users',
      UserHistory().toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserHistory>> Users() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return UserHistory(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


  // Insert a dog into the database.
  //await insertDog(fido);


  // Update Fido's age and save it to the database.
  /*fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );*/
  //await updateDog(fido);


  // Delete Fido from the database.
  //await deleteDog(fido.id);

}
