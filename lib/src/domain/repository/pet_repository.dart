
import 'dart:io';

import 'package:pet_style_mobile/src/data/model/pet/pet.dart';

abstract interface class PetRepository {
  Future<void> createPet(Pet pet, File photo);
  Future<void> updatePet(Pet pet, File? photo);
  Future<void> deletePet(String petId);
  Future<Pet> getPetById(String petId);
  Future<List<String>> loadBreeds(String fileName);
}
