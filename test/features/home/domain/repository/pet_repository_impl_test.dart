import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petadoption/core/datasource/pet_local_model.dart';
import 'package:petadoption/features/home/data/model/pet_model.dart';
import 'package:petadoption/features/home/data/remote/pet_api_service.dart';
import 'package:petadoption/features/home/domain/repository/pet_repository_impl.dart';

class MockPetApiService extends Mock implements PetApiService {}

class MockPetStatusBox extends Mock implements Box<PetLocalModel> {}

void main() {
  late PetRepositoryImpl repository;
  late MockPetApiService mockApiService;
  late MockPetStatusBox mockBox;

  final petModel = PetModel(
    id: '1',
    name: 'Buddy',
    type: 'Dog',
    breed: 'Golden Retriever',
    age: '2 years',
    price: 1000,
    gender: 'Male',
    imageUrl: 'https://example.com/image.jpg',
    location: 'Delhi',
    description: 'Friendly and active dog',
  );

  final petLocalModel = PetLocalModel(
    id: '1',
    name: 'Buddy',
    type: 'Dog',
    breed: 'Golden Retriever',
    age: '2 years',
    price: 1000,
    gender: 'Male',
    imageUrl: 'https://example.com/image.jpg',
    location: 'Delhi',
    description: 'Friendly and active dog',
    isAdopted: true,
    isFavorited: true,
    adoptedAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(
      PetLocalModel(
        id: '',
        name: '',
        type: '',
        breed: '',
        age: '',
        price: 0,
        gender: '',
        imageUrl: '',
        location: '',
        description: '',
      ),
    );
  });

  setUp(() {
    mockApiService = MockPetApiService();
    mockBox = MockPetStatusBox();
    repository = PetRepositoryImpl(mockApiService);

    // ✅ Correct mocking of Hive.box
    when(() => Hive.box<PetLocalModel>('petStatus')).thenReturn(mockBox);
  });

  test(
    'should return PetEntity with local status (adopted, favorited)',
    () async {
      when(
        () => mockApiService.fetchPets(page: 1, limit: 10),
      ).thenAnswer((_) async => [petModel]);
      when(() => mockBox.get('1')).thenReturn(petLocalModel);

      final result = await repository.getAllPets();

      expect(result.length, 1);
      final pet = result.first;

      expect(pet.id, petModel.id);
      expect(pet.name, petModel.name);
      expect(pet.isAdopted, true);
      expect(pet.isFavorited, true);

      verify(() => mockApiService.fetchPets(page: 1, limit: 10)).called(1);
      verify(() => mockBox.get('1')).called(1);
    },
  );

  test(
    'should return PetEntity with default false status if local is null',
    () async {
      when(
        () => mockApiService.fetchPets(page: 1, limit: 10),
      ).thenAnswer((_) async => [petModel]);
      when(() => mockBox.get('1')).thenReturn(null);

      final result = await repository.getAllPets();

      expect(result.length, 1);
      final pet = result.first;

      expect(pet.id, petModel.id);
      expect(pet.isAdopted, false);
      expect(pet.isFavorited, false);
    },
  );
}
