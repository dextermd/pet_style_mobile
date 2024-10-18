part of 'onboarding_bloc.dart';

sealed class OnboardingEvent {}

class ChangePage extends OnboardingEvent {
  final int page;

  ChangePage(this.page);
}
