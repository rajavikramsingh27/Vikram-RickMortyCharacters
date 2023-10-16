
import 'package:flutter/material.dart';
import 'package:qurhealth_task/Views/RickMortyCharacters.dart';

import 'Styles/ColorStyle.dart';
import 'BLoC/rick_morty_characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RickMortyCharactersCubit()),
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

