import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import './miner_block_item.dart';
import '../providers/miner_block_provider.dart';
import '../models/miner_block_list.dart';

class MinerGrid extends StatelessWidget {
  final int length;
  final int bombNumber;
  final List<MinerBlock> minerList;
  final List<Tuple2<int, int>> bombList;

  MinerGrid(
    this.length,
    this.bombNumber,
    this.minerList,
    this.bombList,
  );

  @override
  Widget build(BuildContext context) {
    var minerBlockList = MinerBlockList(minerList, bombList, length);
    minerBlockList.updateBombsAround();

    //debugging purposes.
    //print(minerList);
    //print(bombList);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: length * length,
        itemBuilder: (_, index) {
          return ChangeNotifierProvider.value(
            value: minerList[index],
            child: MinerBlockItem(),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: length,
        ),
      ),
    );
  }
}
