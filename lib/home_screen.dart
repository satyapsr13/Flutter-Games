// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'RouletteSpinGame/roulette_spin_game.dart';
import 'SpinWheelGame/game.dart';

class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Games'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SpinWheelGameScreen())));
                      },
                      child: Container(
                        height: mq.height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Spin Wheel Game',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RouletteScreen())));
                      },
                      child: Container(
                        height: mq.height * 0.1,
                        child: Text(
                          'Roulette Game',
                          style: const TextStyle(),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
      //floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
    ;
  }
}
