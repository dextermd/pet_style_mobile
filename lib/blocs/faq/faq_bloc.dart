import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/faq/faq.dart';
import 'package:pet_style_mobile/src/domain/repository/faq_repository.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final FaqRepository _faqRepository;
  FaqBloc(this._faqRepository) : super(FaqInitial()) {
    on<FaqFetchEvent>(_onFaqFetchEvent);
  }

  Future<void> _onFaqFetchEvent(
      FaqFetchEvent event, Emitter<FaqState> emit) async {
    if (state is! FaqLoaded) {
      emit(FaqLoading());
    }
    try {
      final List<Faq> faqs = await _faqRepository.getAll();
      if (faqs.isEmpty) {
        emit(FaqEmpty());
        return;
      }
      emit(FaqLoaded(faqs: faqs));
    } catch (e) {
      emit(FaqLoadedError(message: e.toString()));
    }
  }
}
