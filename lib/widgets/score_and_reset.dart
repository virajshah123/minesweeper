import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/miner_block_list.dart';
import 'package:provider/provider.dart';

class ScoreAndReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final minerBlockList = Provider.of<MinerBlockList>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Consumer<MinerBlockList>(
        builder: (ctx, minerBlokList, _) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  minerBlokList.reset();
                },
                child: Text("Restart"),
              ),
              Text("Score: ${minerBlokList.score}"),
            ],
          );
        },
      ),
    );
  }
}
