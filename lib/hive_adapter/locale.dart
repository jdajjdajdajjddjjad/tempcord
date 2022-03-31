part of '../hive_adapter.dart';

class _LocaleTypeAdapter extends TypeAdapter<Locale> {
  @override
  final int typeId = 1;

  @override
  Locale read(BinaryReader reader) {
    Map property = reader.readMap();

    return Locale.fromSubtags(
        languageCode: property["lang"],
        countryCode: property["country"],
        scriptCode: property["script"]);
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    Map<String, String> property = {"lang": obj.languageCode};

    if (obj.countryCode != null) {
      property["country"] = obj.countryCode!;
    }

    if (obj.scriptCode != null) {
      property["script"] = obj.scriptCode!;
    }

    writer.writeMap(property);
  }
}
