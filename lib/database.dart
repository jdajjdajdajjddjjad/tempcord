import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

Database? _profileRecordDB = null;

Future<String> get databaseDirPath => Platform.isAndroid || Platform.isIOS
    ? getDatabasesPath()
    : path_provider.getApplicationSupportDirectory().then((dir) => dir.path);

Future<Database> get profileRecordDB async {
  if (_profileRecordDB != null && _profileRecordDB!.isOpen) {
    // Skip open database action if is opened
    return _profileRecordDB!;
  }

  String databasePath = path.join(await databaseDirPath, "profile_record.db");

  _profileRecordDB =
      await openDatabase(databasePath, version: 1, onConfigure: (db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }, onCreate: (db, version) async {
    await db.execute(
        "CREATE TABLE profiles (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, animal TEXT NOT NULL, image BLOB)");
    await db.execute(
        "CREATE TABLE btr (id INTEGER PRIMARY KEY AUTOINCREMENT, pid INTEGER NOT NULL, temp REAL NOT NULL, unit TEXT NOT NULL, recordedAt TEXT NOT NULL, FOREIGN KEY (pid) REFERENCES profiles (id) ON UPDATE RESTRICT ON DELETE RESTRICT");
  });

  return _profileRecordDB!;
}
