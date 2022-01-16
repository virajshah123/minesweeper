import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

enum BlockStatus {
  pressed,
  notPressed,
}

class MinerBlock with ChangeNotifier {
  final Tuple2<int, int> position;
  final List<Tuple2<int, int>> neighbourPositions;
  bool isBomb;
  BlockStatus status;
  int bombsAround;

  MinerBlock({
    @required this.position,
    @required this.neighbourPositions,
    @required this.status,
    @required this.isBomb,
    @required this.bombsAround,
  });

  void toggleBlockStatusToPressed() {
    status = BlockStatus.pressed;
    notifyListeners();
  }

  void toggleBlockStatusToUnpressed() {
    status = BlockStatus.notPressed;
    //no need to notify listeners since our
    //minerList is doing that
  }

  bool isZero() {
    // check whether this is a block with no bomb
    // neighbours.
    return (bombsAround == 0);
  }
}
