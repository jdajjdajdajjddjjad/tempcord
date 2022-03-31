part of '../hive_adapter.dart';

class _ThemeModeTypeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 0;

  @override
  ThemeMode read(BinaryReader reader) {
    int idx = reader.readInt();

    return ThemeMode.values[idx];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }
}
