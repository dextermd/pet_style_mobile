import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/domain/repository/pet_repository.dart';

part 'pet_form_event.dart';
part 'pet_form_state.dart';

class PetFormBloc extends Bloc<PetFormEvent, PetFormState> {
  final PetRepository petRepository;

  PetFormBloc(this.petRepository) : super(PetFormInitial()) {
    on<LoadBreeds>(
      (event, emit) async {
        emit(PetBreedsLoading());
        try {
          final dogBreeds = await petRepository.loadBreeds('dog_breeds.json');
          final catBreeds = await petRepository.loadBreeds('cat_breeds.json');
          PetFormState.dogBreedsL = dogBreeds;
          PetFormState.catBreedsL = catBreeds;
          if (dogBreeds.isNotEmpty && catBreeds.isNotEmpty) {
            emit(PetBreedsLoaded(dogBreeds: dogBreeds, catBreeds: catBreeds));
          } else {
            emit(const PetBreedsLoadError(
                message: 'Не удалось загрузить породы животных'));
          }
        } catch (e, st) {
          logHandle(e.toString(), st);
          emit(PetBreedsLoadError(message: e.toString()));
        }
      },
    );

    on<CreatePet>(
      (event, emit) async {
        emit(PetCreating());
        try {
          if (event.photo == null) {
            emit(const PetCreateError(message: 'Пожалуйста, добавьте фото питомца'));
            return;
          }
          await petRepository.createPet(event.pet, event.photo!);
          emit(PetCreated());
        } catch (e) {
          logDebug('CreatePet error: $e');
          emit(PetCreateError(message: e.toString()));
        }
      },
    );

    on<LoadPet>(
      (event, emit) async {
        emit(PetLoading());
        try {
          PetFormState.loadedPet = await petRepository.getPetById(event.id);
          emit(PetLoaded(PetFormState.loadedPet!));
        } catch (e) {
          logDebug('LoadPet error: $e');
          emit(PetLoadError(message: e.toString()));
        }
      },
    );

    on<UpdatePet>(
      (event, emit) async {
        emit(PetUpdating());
        try {
          await petRepository.updatePet(event.pet, event.photo);
          emit(PetUpdated());
        } catch (e) {
          logDebug('UpdatePet error: $e');
          emit(PetUpdateError(message: e.toString()));
        }
      },
    );

    on<DeletePet>(
      (event, emit) async {
        emit(PetDeleting());
        try {
          await petRepository.deletePet(event.id);
          emit(PetDeleted());
        } catch (e) {
          logDebug('DeletePet error: $e');
          emit(PetDeleteError(message: e.toString()));
        }
      },
    );
  }
}
