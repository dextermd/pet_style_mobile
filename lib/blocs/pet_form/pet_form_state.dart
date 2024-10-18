// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pet_form_bloc.dart';

sealed class PetFormState extends Equatable {
  const PetFormState();

  static List<String> dogBreedsL = [];
  static List<String> catBreedsL = [];
  static Pet? loadedPet;

  @override
  List<Object> get props => [];
}

final class PetFormInitial extends PetFormState {}

class PetCreating extends PetFormState {}

class PetCreated extends PetFormState {}

class PetCreateError extends PetFormState {
  final String message;

  const PetCreateError({required this.message});
}

class PetLoading extends PetFormState {}

class PetLoaded extends PetFormState {
  final Pet pet;

  const PetLoaded(this.pet);

  @override
  List<Object> get props => [pet];
}

class PetLoadError extends PetFormState {
  final String message;

  const PetLoadError({required this.message});
}

class PetBreedsLoading extends PetFormState {}

class PetBreedsLoaded extends PetFormState {
  final List<String> dogBreeds;
  final List<String> catBreeds;

  const PetBreedsLoaded({
    required this.dogBreeds,
    required this.catBreeds,
  });

  @override
  List<Object> get props => [dogBreeds, catBreeds];
}

class PetBreedsLoadError extends PetFormState {
  final String message;

  const PetBreedsLoadError({required this.message});
}

class PetUpdating extends PetFormState {}

class PetUpdated extends PetFormState {}

class PetUpdateError extends PetFormState {
  final String message;

  const PetUpdateError({required this.message});
}

class PetDeleting extends PetFormState {}

class PetDeleted extends PetFormState {}

class PetDeleteError extends PetFormState {
  final String message;

  const PetDeleteError({required this.message});
}