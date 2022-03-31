import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_size/window_size.dart' as window_size;

import 'database.dart' as tempcord_db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite binding
  await _sqlInit();

  // Hive binding
  await _hiveInit();
}

Future<void> _sqlInit() async {
  if (Platform.isLinux || Platform.isWindows) {
    // Initalize SQLite library
    sqfliteFfiInit();
  }

  // Override factory to FFI
  databaseFactory = databaseFactoryFfi;

  await tempcord_db.profileRecordDB.then((db) async => await db.close());
}

Future<void> _hiveInit() async {
  String hiveDbDir = path.join(await tempcord_db.databaseDirPath, "hive");

  await Hive.initFlutter(hiveDbDir);
}

void _windowDisplayConfig() {
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    window_size.setWindowMinSize(const Size(800, 450));
    window_size.setWindowMaxSize(Size.infinite);
  }
}
