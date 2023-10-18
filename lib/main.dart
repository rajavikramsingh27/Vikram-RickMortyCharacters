
import 'package:flutter/material.dart';
import 'package:qurhealth_task/BLoC/RickMortyCharactersDetails/rick_morty_characters_details_cubit.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersDetailsRepo.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersRepo.dart';
import 'package:qurhealth_task/Utils/HiveDBKonstants.dart';
import 'package:qurhealth_task/Views/RickMortyCharacters.dart';

import 'Styles/ColorStyle.dart';
import 'BLoC/rick_morty_characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Directory document = await getApplicationDocumentsDirectory();
  print(document.path);

  print(HiveDBKonstants.RickMorty.toString());

  Hive.init(document.path);

  await Hive.openBox(HiveDBKonstants.RickMorty.value);

  final rickMortyCharactersRepo = RickMortyCharactersRepo();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RickMortyCharactersCubit(di_RickMortyCharactersRepo: rickMortyCharactersRepo)),
      BlocProvider(create: (context) => RickMortyCharactersDetailsCubit()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty Characters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: ColorStyle.primaryF5F5F5.toMaterialColor()),
      home: const RickMortyCharacters(),
    );
  }
}

