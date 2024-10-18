import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pet_style_mobile/core/helpers/api_exception.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/domain/repository/pet_repository.dart';


class PetRepositoryImpl implements PetRepository {
  final Dio dio;

  PetRepositoryImpl({required this.dio});

  @override
  Future<List<String>> loadBreeds(String fileName) async {
    final String response =
        await rootBundle.loadString('assets/json/$fileName');
    final List<dynamic> data = json.decode(response);
    return data.cast<String>();
  }

  @override
  Future<void> createPet(Pet pet, File photo) async {
    int weight = pet.weight!;
    String memtype = photo.path.split('.').last;
    try {
      final FormData formData = FormData.fromMap({
        'name': pet.name,
        'type': pet.type,
        'breed': pet.breed,
        'gender': pet.gender,
        'weight': weight,
        'behavior': pet.behavior,
        'description': pet.description,
        'birthDate': pet.birthDate,
        'photo': '',
        'file': await MultipartFile.fromFile(
          photo.path,
          contentType: MediaType('image', memtype),
        ),
      });

      logDebug('formData: ${formData.fields}');
      final Response response = await dio.post(
        AppSecrets.petsUrl,
        data: formData,
      );
      logDebug('createPet response: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: AppSecrets.petsUrl),
          response: response,
          type: DioExceptionType.connectionError,
        );
      }
    } on DioException catch (error) {
      logDebug('createPet error: $error');
      if (error.response?.statusCode == 409) {
        throw ('Ошибка\nПитомец с таким именем уже существует');
      }
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<Pet> getPetById(String petId) async {
    try {
      final Response response = await dio.get('${AppSecrets.petsUrl}/$petId');
      logDebug('getPetById response: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Pet.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '${AppSecrets.petsUrl}/$petId'),
          response: response,
          type: DioExceptionType.connectionError,
        );
      }
    } on DioException catch (error) {
      logDebug('getPetById error: $error');
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }

  @override
  Future<void> updatePet(Pet pet, File? photo) async {
    String? memtype;
    logDebug('updatePet photo: $photo');
    if (photo != null) {
      memtype = photo.path.split('.').last;
    }
    int weight = pet.weight!;
    String petId = pet.id!;

    try {
      final formDataMap = {
        'name': pet.name,
        'type': pet.type,
        'breed': pet.breed,
        'gender': pet.gender,
        'weight': weight,
        'behavior': pet.behavior,
        'description': pet.description,
        'birthDate': pet.birthDate,
        'id': pet.id,
      };

      if (photo != null) {
        formDataMap['file'] = await MultipartFile.fromFile(photo.path,
            contentType: MediaType('image', memtype!));
      }

      final FormData formData = FormData.fromMap(formDataMap);

      logDebug('formData: ${formData.fields}');
      final Response response = await dio.patch(
        '${AppSecrets.petsUrl}/$petId',
        data: formData,
      );
      logDebug('updatePet response: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: AppSecrets.petsUrl),
          response: response,
          type: DioExceptionType.connectionError,
        );
      }
    } on DioException catch (error) {
      logDebug('updatePet error: $error');
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }
  
  @override
  Future<void> deletePet(String petId) {
    try {
      return dio.delete('${AppSecrets.petsUrl}/$petId');
    } on DioException catch (error) {
      logDebug('deletePet error: $error');
      throw ApiException.checkException(error);
    } catch (e, st) {
      logHandle(e.toString(), st);
      throw ('Ошибка\nПопробуйте позже');
    }
  }
}
