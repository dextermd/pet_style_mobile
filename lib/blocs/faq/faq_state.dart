part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

final class FaqInitial extends FaqState {}

final class FaqLoading extends FaqState {}

final class FaqLoaded extends FaqState {
  final List<Faq> faqs;

  const FaqLoaded({required this.faqs});

  @override
  List<Object> get props => [faqs];
}

final class FaqLoadedError extends FaqState {
  final String message;

  const FaqLoadedError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FaqEmpty extends FaqState {}