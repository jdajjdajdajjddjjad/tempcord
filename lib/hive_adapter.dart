import 'package:flutter/material.dart';
import 'package:hive/hive.dart'
    show Hive, TypeAdapter, BinaryWriter, BinaryReader;

part 'hive_adapter/theme_mode.dart';
part 'hive_adapter/locale.dart';

void setAdapters() => <TypeAdapter>[
      _ThemeModeTypeAdapter(),
      _LocaleTypeAdapter()
    ].forEach((a) => Hive.registerAdapter(a, override: true));
