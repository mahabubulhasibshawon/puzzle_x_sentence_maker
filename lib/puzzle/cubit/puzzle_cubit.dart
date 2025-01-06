import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class PuzzleCubit extends Cubit<List<int>> {
  PuzzleCubit() : super(List.generate(8, (index) => index + 1)..add(0));

  void shuffleTiles() {
    final newState = List<int>.from(state);
    newState.shuffle(Random());
    emit(newState);
  }

  void moveTile(int index) {
    final blankIndex = state.indexOf(0);

    // Check if the tapped tile is adjacent to the blank space
    if (isAdjacent(index, blankIndex)) {
      final newState = List<int>.from(state);
      newState[blankIndex] = newState[index];
      newState[index] = 0; // Blank space moves to the tapped tile
      emit(newState);
    }
  }

  bool isAdjacent(int index1, int index2) {
    final row1 = index1 ~/ 3;
    final col1 = index1 % 3;
    final row2 = index2 ~/ 3;
    final col2 = index2 % 3;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }
}
