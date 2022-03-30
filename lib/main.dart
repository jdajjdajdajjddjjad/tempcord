import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database.dart' as tempcord_db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite binding
  await _sqlInit();
}

Future<void> _sqlInit() async {
  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;

  await tempcord_db.profileRecordDB.then((db) async => await db.close());
}
