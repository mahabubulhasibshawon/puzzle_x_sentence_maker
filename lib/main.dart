import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/puzzle_page.dart';
import 'package:puzzle/sentence_maker/sentence_maker.dart';

import 'puzzle/cubit/puzzle_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3x3 Puzzle',
      home: BlocProvider(
        create: (_) => PuzzleCubit()..shuffleTiles(),
        child: SentenceMaker(),
      ),
    );
  }
}
