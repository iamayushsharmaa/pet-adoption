import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petadoption/theme/theme_provider.dart';

import 'config/routes.dart';
import 'core/datasource/pet_local_model.dart';
import 'features/home/data/model/pet_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PetModelAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PetLocalModelAdapter());
  }

  await Hive.openBox<PetModel>('cachedPets');
  await Hive.openBox<PetLocalModel>('petStatus');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createRouter(),
      theme: ThemeProvider.getTheme(false),
      darkTheme: ThemeProvider.getTheme(true),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
