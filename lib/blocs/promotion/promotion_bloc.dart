import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/promotion/promotion.dart';
import 'package:pet_style_mobile/src/domain/repository/promotion_repository.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final PromotionRepository _promotionRepository;
  PromotionBloc(this._promotionRepository) : super(PromotionInitial()) {
    on<PromotionFetchEvent>(_onPromotionFetchEvent);
  }

  Future<void> _onPromotionFetchEvent(
      PromotionFetchEvent event, Emitter<PromotionState> emit) async {
    if (state is! PromotionLoaded) {
      emit(PromotionLoading());
    }
    try {
      final List<Promotion> promotions = await _promotionRepository.getAll();
      if (promotions.isEmpty) {
        emit(PromotionEmpty());
        return;
      }
      emit(PromotionLoaded(promotions: promotions));
    } catch (e) {
      emit(PromotionLoadedError(message: e.toString()));
    }
  }
}
