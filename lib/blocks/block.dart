import 'package:flutter/material.dart';
import 'package:tetris/game.dart';
import '../point.dart';

class Block {
  // ignore: non_constant_identifier_names
  final fixed_length_list_of_points = List<Point>.filled(4, Point(0, 0));
  late Point rotationCenter;
  late Color color;

  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        if (canMoveToSide(-1)) {
          for (var p in fixed_length_list_of_points) {
            p.x -= 1;
          }
        }
        break;
      case MoveDir.RIGHT:
        if (canMoveToSide(1)) {
          for (var p in fixed_length_list_of_points) {
            p.x += 1;
          }
        }
        break;
      case MoveDir.DOWN:
        for (var p in fixed_length_list_of_points) {
          p.y += 1;
        }
        break;
    }
  }

  bool canMoveToSide(int moveAmt) {
    bool retVal = true;

    for (var point in fixed_length_list_of_points) {
      if (point.x + moveAmt < 0 || point.x + moveAmt >= BOARD_WIDTH) {
        retVal = false;
      }
    }
    return retVal;
  }

  bool allPointsInside() {
    bool retVal = true;

    for (var point in fixed_length_list_of_points) {
      if (point.x < 0 || point.x >= BOARD_WIDTH) {
        retVal = false;
      }
    }
    return retVal;
  }

  void rotateRight() {
    for (var point in fixed_length_list_of_points) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + x - rotationCenter.x;
    }
    if (allPointsInside() == false) rotateLeft();
  }

  void rotateLeft() {
    for (var point in fixed_length_list_of_points) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    }
    if (allPointsInside() == false) rotateRight();
  }

  bool isAtBottom() {
    int lowestPoint = 0;

    for (var point in fixed_length_list_of_points) {
      if (point.y > lowestPoint) {
        lowestPoint = point.y;
      }
    }
    if (lowestPoint >= BOARD_HEIGHT - 1) {
      return true;
    } else {
      return false;
    }
  }
}
