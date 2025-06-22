import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../model/pet_model.dart';

class PetApiService {
  final Dio dio;
  final Box<PetModel> _cacheBox;

  PetApiService(this.dio, this._cacheBox);

  Future<List<PetModel>> fetchPets() async {
    try {
      final response = await dio.get(
        'https://6857a33021f5d3463e55b51a.mockapi.io/petadoption/v1/pets',
      );

      final pets = (response.data as List)
          .map((e) => PetModel.fromJson(e))
          .toList();

      // Cache to Hive
      await _cacheBox.clear();
      for (var pet in pets) {
        await _cacheBox.put(pet.id, pet);
      }

      return pets;
    } catch (e) {
      // On failure, return cached data
      return _cacheBox.values.toList();
    }
  }

  List<PetModel> getCachedPets() {
    return _cacheBox.values.toList();
  }
}
