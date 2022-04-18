// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tetris/blocks/alive_point.dart';
import 'package:tetris/userinput.dart';
import 'helper.dart';
import 'dart:async';
import 'blocks/block.dart';
import 'score_display.dart';
import 'userinput.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDir { LEFT, RIGHT, DOWN }

const double WIDTH = 200;
const double HEIGHT = 400;

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;
const double POINT_SIZE = 20; //angabe in Px

const int GAME_SPEED = 400; // spielgeschwindigkeit
Timer timer = Timer(const Duration(milliseconds: 1), () {});

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {
  //LastButtonPressed soll sich ändern können, bzw der State soll sich hier ändern können
  LastButtonPressed performAction = LastButtonPressed.NONE; //anfangs State
  late Block currentBlock;
  List<AlivePoint> alivePoints = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRamdomBlock();
    });
    timer = Timer.periodic(
      const Duration(milliseconds: GAME_SPEED),
      onTimeTick,
    );
  }

  void checkForUserInput() {
    if (performAction != LastButtonPressed.NONE) {
      setState(() {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock.move(MoveDir.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock.move(MoveDir.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock.rotateRight();
            break;
          default:
            break;
        }

        performAction = LastButtonPressed.NONE;
      });
    }
  }

  void safeOldBlock() {
    for (var point in currentBlock.fixed_length_list_of_points) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock.color);
      setState(() {
        alivePoints.add(newPoint);
      });
    }
  }

  bool isAboveOldBlock() {
    bool retVal = false;

    for (var oldPoint in alivePoints) {
      if (oldPoint
          .checkIfPointsCollide(currentBlock.fixed_length_list_of_points)) {
        retVal = true;
      }
    }

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);

      for (var point in alivePoints) {
        if (point.y < row) {
          point.y += 1;
        }
      }
      score += 1;
    });
  }

  void removeFullRows() {
    for (int currentRow = 0; currentRow < BOARD_HEIGHT; currentRow++) {
      //kontrolliert alle Reichen von oben nach unten
      int counter = 0;

      for (var point in alivePoints) {
        if (point.y == currentRow) {
          counter++;
        }
      }
      if (counter >= BOARD_WIDTH) {
        //entferne currentRow
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool retVal = false;

    for (var element in alivePoints) {
      if (element.y <= 0) {
        retVal = true;
      }
    }
    return retVal;
  }

  void onTimeTick(Timer time) {
    if (/*currentBlock == null ||*/ playerLost()) return;

//entferne volle Reihe
    removeFullRows();
    //prüfe, ob der block schon auf dem Boden ist
    if (currentBlock.isAtBottom() || isAboveOldBlock()) {
      //safe Block
      safeOldBlock();
      //neuer random Block
      setState(() {
        currentBlock = getRamdomBlock();
      });
    } else {
      setState(() {
        currentBlock.move(MoveDir.DOWN);
      });
      checkForUserInput();
    }
  }

  Widget? drawTetrisBlocks() {
    //  if (currentBlock == null) return null; currentBlock kann nicht null sein, noch nicht..
    List<Positioned> visiblePoints = [];

    //aktueller BLock
    for (var point in currentBlock.fixed_length_list_of_points) {
      Positioned newPoint = Positioned(
        child: getTetrisPoint(currentBlock.color),
        left: point.x * POINT_SIZE,
        top: point.y * POINT_SIZE,
      );
      visiblePoints.add(newPoint);
    }

//oldBlock
    for (var point in alivePoints) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(point.color),
          left: point.x * POINT_SIZE,
          top: point.y * POINT_SIZE,
        ),
      );
    }

    return Stack(
      children: visiblePoints,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: WIDTH,
            height: HEIGHT,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: (playerLost() == false)
                ? drawTetrisBlocks()
                : getGameOverText(score),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScoreDisplay(score),
            UserInput(onActionButtonPressed),
          ],
        )
      ],
    );
  }
}
