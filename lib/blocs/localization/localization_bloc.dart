import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/language/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }
  void onChangeLanguage(
      ChangeLanguage event, Emitter<LocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        languagePrefsKey, event.selectedLanguage.value.languageCode);

    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  void onGetLanguage(GetLanguage event, Emitter<LocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? selectLang = prefs.getString(languagePrefsKey);

    emit(
      state.copyWith(
        selectedLanguage: Language.values.firstWhere(
            (element) => element.value.languageCode == selectLang,
            orElse: () => Language.russian),
      ),
    );
  }
}

const languagePrefsKey = 'languagePrefs';
