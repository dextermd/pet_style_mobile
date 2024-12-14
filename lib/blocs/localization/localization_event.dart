part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LocalizationEvent {
  final Language selectedLanguage;

  const ChangeLanguage(this.selectedLanguage);

  @override
  List<Object> get props => [selectedLanguage];
}

class GetLanguage extends LocalizationEvent {}
