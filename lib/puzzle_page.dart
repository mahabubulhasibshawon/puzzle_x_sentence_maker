import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/puzzle_cubit.dart';
import 'image_tile.dart';

class PuzzlePage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/puzzle_part_1.jpg',
    'assets/puzzle_part_2.jpg',
    'assets/puzzle_part_3.jpg',
    'assets/puzzle_part_4.jpg',
    'assets/puzzle_part_5.jpg',
    'assets/puzzle_part_6.jpg',
    'assets/puzzle_part_7.jpg',
    'assets/puzzle_part_8.jpg',
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('3x3 Puzzle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<PuzzleCubit>().shuffleTiles(),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<PuzzleCubit, List<int>>(
          builder: (context, tiles) {
            return Container(
              width:  300,
              height:  300,
              color: Colors.pink.shade50,
              child: Stack(
                children: tiles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tileValue = entry.value;

                  // Calculate the position for the tile
                  final row = index ~/ 3;
                  final col = index % 3;

                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 30000),
                    curve: Curves.elasticIn,
                    top: row *  100.0,
                    left: col * 100.0,
                    child: GestureDetector(
                      onTap: () => context.read<PuzzleCubit>().moveTile(index),
                      child: tileValue == 0
                          ? Container(
                        width: 100,
                        height: 100,
                        color: Colors.white, // Blank tile
                      )
                          : ImageTile(
                        imagePath: imagePaths[tileValue - 1],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

