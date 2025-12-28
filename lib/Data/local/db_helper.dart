import 'dart:io';

import 'package:notes_cubit/Data/model/note_model.dart';
import 'package:notes_cubit/domain/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper instance = DbHelper._();

  Database? mdb;

  Future<Database> initDb() async {
    mdb ??= await open();
    return mdb!;
  }

  Future<Database> open() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "NotesDb.db");

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table ${AppConstants.notesTable} ( ${AppConstants.notesId} integer primary key autoincrement, ${AppConstants.notesTitle} text , ${AppConstants.notesDesc} text , ${AppConstants.notesCreatedAt} text)",
        );
      },
    );
  }

  Future<bool> addNotes({required NotesModel newNotes})async{
    var db = await initDb();
    int rowsEffected = await db.insert(AppConstants.notesTable, newNotes.toMap());
    return rowsEffected>0;
  }

  Future<List<NotesModel>> getNotes()async{
    List<NotesModel> mNotes = [];
    var db =await  initDb();
    List<Map<String,dynamic>> allNotes = await db.query(AppConstants.notesTable);

    for(Map<String,dynamic> eachNotes in allNotes){
      mNotes.add(NotesModel.fromMap(eachNotes));
    }
    return mNotes;
  }

  Future<bool> updateNotes({required NotesModel newNotes , required int id})async{
    var db =await initDb();
    int rowsEffected = await db.update(AppConstants.notesTable, newNotes.toMap(),where: '${AppConstants.notesId} = ?',whereArgs: [id]);
    return rowsEffected>0;
  }

  Future<bool> deleteNotes({required int id})async{
    var db =await initDb();
    int rowsEffected = await db.delete(AppConstants.notesTable,where:"${AppConstants.notesId} = ?",whereArgs: [id]);
    return rowsEffected>0;
  }
}
