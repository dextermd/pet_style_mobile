part of 'promotion_bloc.dart';

sealed class PromotionState extends Equatable {
  const PromotionState();
  
  @override
  List<Object> get props => [];
}

final class PromotionInitial extends PromotionState {}
