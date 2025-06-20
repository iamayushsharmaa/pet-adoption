import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petadoption/theme/theme_provider.dart';

import 'config/routes.dart';
import 'features/favorite/data/datasource/pet_local_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(PetLocalModelAdapter());
  await Hive.openBox<PetLocalModel>('pets');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
