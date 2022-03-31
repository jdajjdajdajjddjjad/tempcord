import 'package:fluent_ui/fluent_ui.dart';

class TempcordGlobalSetting {
  final ThemeMode themeMode;
  final Locale locale;

  const TempcordGlobalSetting({required this.themeMode, required this.locale});

  TempcordGlobalSetting updateThemeMode(ThemeMode themeMode) =>
      TempcordGlobalSetting(themeMode: themeMode, locale: this.locale);

  TempcordGlobalSetting updateLocale(Locale locale) =>
      TempcordGlobalSetting(themeMode: this.themeMode, locale: locale);
}
