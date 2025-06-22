import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petadoption/features/home/data/model/pet_model.dart';
import 'package:petadoption/features/home/data/remote/pet_api_service.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockBox<T> extends Mock implements Box<T> {}

void main() {
  late MockDio mockDio;
  late MockBox<PetModel> mockBox;
  late PetApiService petApiService;

  final petJson = {
    'id': '1',
    'name': 'Charlie',
    'type': 'Dog',
    'breed': 'Labrador',
    'age': '2 years',
    'price': 200,
    'gender': 'Male',
    'imageUrl': 'https://example.com/image.jpg',
    'location': 'New York',
    'description': 'Friendly dog',
  };

  final petModel = PetModel.fromJson(petJson);
  final petEntity = petModel.toEntity();

  setUp(() {
    mockDio = MockDio();
    mockBox = MockBox<PetModel>();
    petApiService = PetApiService(mockDio, mockBox);
    reset(mockDio);
    reset(mockBox);
    registerFallbackValue(RequestOptions(path: '/pets'));
  });

  test('fetchPets returns pets from API and caches them', () async {
    when(() => mockDio.get('/pets', queryParameters: {'page': 1})).thenAnswer(
      (_) async => Response(
        data: [petJson],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/pets'),
      ),
    );

    when(() => mockBox.clear()).thenAnswer((_) async => 0);
    when(
      () => mockBox.put(petModel.id, petModel),
    ).thenAnswer((_) async => Future.value());

    final result = await petApiService.fetchPets();

    expect(result.length, 1);
    expect(result.first.name, 'Charlie');
    expect(result.first.breed, 'Labrador');

    verify(() => mockDio.get('/pets', queryParameters: {'page': 1})).called(1);
    verify(() => mockBox.clear()).called(1);
    verify(() => mockBox.put(petModel.id, petModel)).called(1);
  });

  test('fetchPets returns cached pets on API error', () async {
    when(() => mockDio.get('/pets', queryParameters: {'page': 1})).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/pets'),
        error: 'Network error',
      ),
    );

    when(() => mockBox.values).thenReturn([petModel]);

    final result = await petApiService.fetchPets();

    expect(result.length, 1);
    expect(result.first.name, 'Charlie');
    expect(result.first.breed, 'Labrador');

    verify(() => mockDio.get('/pets', queryParameters: {'page': 1})).called(1);
    verify(() => mockBox.values).called(1);
  });

  test('fetchPets handles empty API response', () async {
    when(() => mockDio.get('/pets', queryParameters: {'page': 1})).thenAnswer(
      (_) async => Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/pets'),
      ),
    );

    when(() => mockBox.clear()).thenAnswer((_) async => 0);
    when(() => mockBox.values).thenReturn([]);

    final result = await petApiService.fetchPets();

    expect(result.isEmpty, true);
    verify(() => mockDio.get('/pets', queryParameters: {'page': 1})).called(1);
    verify(() => mockBox.clear()).called(1);
    verifyNever(() => mockBox.put(any(), any()));
  });

  test('fetchPets handles partial JSON from API', () async {
    final partialJson = {'name': 'Bella'};
    final partialPetModel = PetModel.fromJson(partialJson);

    when(() => mockDio.get('/pets', queryParameters: {'page': 1})).thenAnswer(
      (_) async => Response(
        data: [partialJson],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/pets'),
      ),
    );

    when(() => mockBox.clear()).thenAnswer((_) async => 0);
    when(
      () => mockBox.put(partialPetModel.id, partialPetModel),
    ).thenAnswer((_) async => Future.value());

    final result = await petApiService.fetchPets();

    expect(result.length, 1);
    expect(result.first.name, 'Bella');
    expect(result.first.id, isNotEmpty);
    expect(result.first.type, '');
    expect(result.first.breed, '');
    expect(result.first.age, '');
    expect(result.first.price, 0);
    expect(result.first.gender, '');
    expect(result.first.imageUrl, '');
    expect(result.first.location, '');
    expect(result.first.description, '');

    verify(() => mockDio.get('/pets', queryParameters: {'page': 1})).called(1);
    verify(() => mockBox.clear()).called(1);
    verify(() => mockBox.put(partialPetModel.id, partialPetModel)).called(1);
  });
}
