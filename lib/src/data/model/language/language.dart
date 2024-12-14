import 'dart:ui';

enum Language {
  
  russian(
    Locale('ru', 'RU'),
    'assets/icons/RU.svg',
    'Русский',
  ),

  romanian(
    Locale('ro', 'RO'),
    'assets/icons/RO.svg',
    'Română',
  );

  const Language(this.value, this.iconPath, this.text);

  final Locale value;
  final String iconPath;
  final String text;
}