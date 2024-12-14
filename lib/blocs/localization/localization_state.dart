part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final Language selectedLanguage;

  const LocalizationState({Language? selectedLanguage})
      : selectedLanguage = selectedLanguage ?? Language.romanian;

  @override
  List<Object?> get props => [selectedLanguage];

  LocalizationState copyWith({Language? selectedLanguage}) {
    return LocalizationState(
        selectedLanguage: selectedLanguage ?? selectedLanguage);
  }
}
