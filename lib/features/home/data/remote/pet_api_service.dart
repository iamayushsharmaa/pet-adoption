import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../model/pet_model.dart';

class PetApiService {
  final Dio dio;
  final Box<PetModel> _cacheBox;

  PetApiService(this.dio, this._cacheBox);

  Future<List<PetModel>> fetchPets({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get(
        '/pets',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final pets = (response.data as List)
          .map((e) => PetModel.fromJson(e))
          .toList();

      if (page == 1) {
        await _cacheBox.clear();
      }

      for (var pet in pets) {
        await _cacheBox.put(pet.id, pet);
      }

      return pets;
    } catch (e) {
      return _cacheBox.values.toList();
    }
  }
}

