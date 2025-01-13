part of 'promotion_bloc.dart';

sealed class PromotionEvent extends Equatable {
  const PromotionEvent();

  @override
  List<Object> get props => [];
}

class PromotionFetchEvent extends PromotionEvent {}