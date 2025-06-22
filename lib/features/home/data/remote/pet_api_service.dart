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

      final List<dynamic> data = response.data;
      print('🐶 API Response: $data');

      final pets = data.map((e) => PetModel.fromJson(e)).toList();

      if (page == 1) {
        await _cacheBox.clear();
      }

      for (var pet in pets) {
        await _cacheBox.put(pet.id, pet);
      }

      print("✅ Cached ${pets.length} pets.");
      return pets;
    } catch (e, st) {
      print("❌ API error: $e");
      print("🔍 Stacktrace: $st");
      print("📦 Returning ${_cacheBox.length} cached pets");
      return Future.value(_cacheBox.values.toList());
    }
  }
}
