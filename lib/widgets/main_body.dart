import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../models/miner_block_list.dart';
import '../providers/miner_block_provider.dart';
import 'score_and_reset.dart';
import 'miner_grid.dart';

class MainBody extends StatelessWidget {
  final int length;
  final int bombNumber;

  MainBody(
    this.length,
    this.bombNumber,
  );

  Tuple2<List<MinerBlock>, List<Tuple2<int, int>>> getMinerBombList(
      length, bombNumber) {
    //assigns the bombs randomly to certain cells.
    var bombList = <Tuple2<int, int>>[];
    var rand = new Random();

    for (var i = 1; i <= bombNumber; i++) {
      var isPresent = false;
      var column = rand.nextInt(length);
      var rows = rand.nextInt(length);

      if (i > 1) {
        //check whether that particular location is already present in the list or not.
        for (var location in bombList) {
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
      bombList.add(Tuple2(column, rows));
    }

    var minerList = <MinerBlock>[];
    for (var row = 0; row < length; row++) {
      for (var col = 0; col < length; col++) {
        // make a list of all possible locations.
        var rawneighbourPositions = <Tuple2<int, int>>[
          Tuple2(col - 1, row - 1),
          Tuple2(col, row - 1),
          Tuple2(col + 1, row - 1),
          Tuple2(col - 1, row),
          Tuple2(col + 1, row),
          Tuple2(col - 1, row + 1),
          Tuple2(col, row + 1),
          Tuple2(col + 1, row + 1),
        ];

        //filter this list out.
        var neighbourPositions = <Tuple2<int, int>>[];
        for (var neighbour in rawneighbourPositions) {
          if ((neighbour.item1 >= 0) &&
              (neighbour.item1 < length) &&
              (neighbour.item2 >= 0) &&
              (neighbour.item2 < length)) {
            neighbourPositions.add(neighbour);
          }
        }

        // debugging purposes.
        // print(neighbourPositions);

        var minerBlock = MinerBlock(
          position: Tuple2<int, int>(col, row),
          neighbourPositions: neighbourPositions,
          status: BlockStatus.notPressed,
          isBomb: false,
          bombsAround:
              0, // for the moment set it to 0, we will update it later.
        );

        minerList.add(minerBlock);
      }
    }

    return Tuple2(minerList, bombList);
  }

  @override
  Widget build(BuildContext context) {
    var minerBombListTuple = getMinerBombList(length, bombNumber);
    var minerList = minerBombListTuple.item1;
    var bombList = minerBombListTuple.item2;

    return ChangeNotifierProvider(
      create: (_) => MinerBlockList(minerList, bombList, length),
      child: Column(
        children: [
          MinerGrid(length, bombNumber, minerList, bombList),
          ScoreAndReset(),
        ],
      ),
    );
  }
}
