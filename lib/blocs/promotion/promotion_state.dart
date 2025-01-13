part of 'promotion_bloc.dart';

sealed class PromotionState extends Equatable {
  const PromotionState();
  
  @override
  List<Object> get props => [];
}

final class PromotionInitial extends PromotionState {}

final class PromotionLoading extends PromotionState {}

final class PromotionLoaded extends PromotionState {
  final List<Promotion> promotions;

  const PromotionLoaded({required this.promotions});

  @override
  List<Object> get props => [promotions];
}

final class PromotionLoadedError extends PromotionState {
  final String message;

  const PromotionLoadedError({required this.message});

  @override
  List<Object> get props => [message];
}

final class PromotionEmpty extends PromotionState {}