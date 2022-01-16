import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import '../providers/miner_block_provider.dart';

class MinerBlockList with ChangeNotifier {
  final List<MinerBlock> minerList;
  List<Tuple2<int, int>> bombList;
  final int length;
  var score = 0;

  MinerBlockList(
    this.minerList,
    this.bombList,
    this.length,
  );

  MinerBlock getElementByLocation(location) {
    return minerList.firstWhere((minerBlock) =>
        ((location.item1 == minerBlock.position.item1) &&
            (location.item2 == minerBlock.position.item2)));
  }

  void updateBombsAround() {
    // access each bomb, and then access each of its
    // neighbours and increment their bombs around value by 1.
    for (var location in bombList) {
      var bombBlock = getElementByLocation(location);
      bombBlock.isBomb = true;
      for (var loc in bombBlock.neighbourPositions) {
        var minerBlock = getElementByLocation(loc);

        minerBlock.bombsAround += 1;
      }
    }
  }

  bool onBlockPressed(minerBlock) {
    // render true if pressed on bomb
    // do nothing if pressed on a number
    // open all adjacent blocks where there is a zero if pressed on 0

    if (minerBlock.isBomb) {
      return true;
    } else if (minerBlock.bombsAround != 0) {
      minerBlock.toggleBlockStatusToPressed();
      return false;
    }

    // the number on block is zero
    // list of neighbours still to be pressed.
    // var stillToBePressedLocs = minerBlock.neighbourPositions;
    // while (stillToBePressedLocs.length != 0) {
    //   for (var location in stillToBePressedLocs) {
    //     var block = getElementByLocation(location);
    //     block.toggleBlockStatusToPressed();
    //     if (block.isZero()) {
    //       for (var loc in block.neighbourPositions) {
    //         var b = getElementByLocation(loc);
    //         if (b.status == BlockStatus.notPressed) {
    //           stillToBePressedLocs.add(loc);
    //         }
    //       }
    //     }
    //     stillToBePressedLocs.remove(location);
    //   }
    // }
    minerBlock.toggleBlockStatusToPressed();
    for (var loc in minerBlock.neighbourPositions) {
      var block = getElementByLocation(loc);

      if (block.status == BlockStatus.notPressed && block.bombsAround == 0) {
        onBlockPressed(block);
      }
      block.toggleBlockStatusToPressed();
    }

    return false;
  }

  void resetButtons() {
    for (var minerBlock in minerList) {
      minerBlock.toggleBlockStatusToUnpressed();
      minerBlock.isBomb = false;
      minerBlock.bombsAround = 0;
    }
  }

  void reset() {
    // make new bomb list.
    var newBombList = <Tuple2<int, int>>[];
    var rand = new Random();

    for (var i = 1; i <= bombList.length; i++) {
      var isPresent = false;
      var column = rand.nextInt(length);
      var rows = rand.nextInt(length);

      if (i > 1) {
        //check whether that particular location is already present in the list or not.
        for (var location in newBombList) {
          if (column == location.item1 && rows == location.item2) {
            isPresent = true;
            break;
          }
        }
      }
      //if the value is already present then try again.
      if (isPresent) {
        i--;
        continue;
      }

      // add this location since it is a new location.
      newBombList.add(Tuple2(column, rows));
    }
    bombList = newBombList;
    //make all buttons unpressed and update
    //the new miner list.
    resetButtons();
    updateBombsAround();

    notifyListeners();
  }

  bool gameWon() {
    //check whether the game is won.
    var counter = 0;
    for (var minerBlock in minerList) {
      if (minerBlock.status == BlockStatus.notPressed) {
        counter++;
      }
    }
    if (counter == bombList.length) {
      return true;
    }
    return false;
  }

  void updateScore() {
    //counts the score.
    score = 0;
    for (var minerBlock in minerList) {
      if (minerBlock.status == BlockStatus.pressed) {
        score++;
      }
    }
    notifyListeners();
  }
}
