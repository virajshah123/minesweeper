import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/miner_block_list.dart';
import 'package:provider/provider.dart';

import './not_pressed_button.dart';
import '../providers/miner_block_provider.dart';
import './pressed_button.dart';

class MinerBlockItem extends StatelessWidget {
  showAlertDialog(BuildContext context, MinerBlockList minerList, bool isWon) {
    // set up the button
    Widget restartButton = TextButton(
      child: Text("Restart"),
      onPressed: () {
        Navigator.of(context).pop();
        minerList.reset();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(isWon ? "You Won!" : "Game Over"),
      content: Text(isWon
          ? "Congratulations! You have won."
          : "Oops, you clicked on a bomb, press on restart to play the game again"),
      actions: [
        restartButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final minerBlock = Provider.of<MinerBlock>(context);
    //the  miner list this block is connected to.
    final connectedMinerBlockList = Provider.of<MinerBlockList>(context);

    return InkWell(
      onTap: () {
        var gameover = connectedMinerBlockList.onBlockPressed(minerBlock);
        if (gameover) {
          //render an alertdialogbox.
          showAlertDialog(context, connectedMinerBlockList, false);
        }
        //check if game won.
        if (connectedMinerBlockList.gameWon()) {
          showAlertDialog(context, connectedMinerBlockList, true);
        }

        //update score.
        connectedMinerBlockList.updateScore();
      },
      child: minerBlock.status == BlockStatus.pressed
          ? minerBlock.isBomb
              ? PressedButton("*")
              : PressedButton("${minerBlock.bombsAround}")
          : NotPressedButton(),
    );
  }
}
