import 'package:flutter/material.dart';
import 'package:tetris/blocks/iblock.dart';
import 'blocks/block.dart';
import 'blocks/iblock.dart';
import 'blocks/Jblock.dart';
import 'blocks/Lblock.dart';
import 'blocks/SBlock.dart';
import 'blocks/sqBlock.dart';
import 'blocks/Tblock.dart';
import 'blocks/Zblock.dart';
import 'dart:math';
import 'game.dart';

Block getRamdomBlock() {
  int randomNumber = Random().nextInt(7);
  switch (randomNumber) {
    case 0:
      return IBlock(BOARD_WIDTH);
    case 1:
      return JBlock(BOARD_WIDTH);
    case 2:
      return LBlock(BOARD_WIDTH);
    case 3:
      return SBlock(BOARD_WIDTH);
    case 4:
      return SquareBlock(BOARD_WIDTH);
    case 5:
      return TBlock(BOARD_WIDTH);
    case 6:
      return ZBlock(BOARD_WIDTH);
    default:
      return IBlock(BOARD_WIDTH);
  }
}

Widget getTetrisPoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: new BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
    ),
  );
}

Widget getGameOverText(int score) {
  return Center(
    child: Text(
      'Game Over\n End Score: $score',
      style: const TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 3.0,
              offset: Offset(2.0, 2.0),
            )
          ]),
    ),
  );
}
