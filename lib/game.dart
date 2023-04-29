// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

// import 'package:math/ma  '
class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  List<double> sectors = [
    100,
    20,
    0.15,
    0.5,
    50,
    20,
    100,
    50,
    20,
    50,
  ];
  int randomSectorIndex = -1;
  List<double> sectorRadians = [];
  double angle = 0;
  bool spinning = false;
  double earnedValue = 0;
  double totalEarnings = 0;
  int spins = 0;
  math.Random random = math.Random();

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    generateSectorRadions();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    Tween<double> tween = Tween<double>(begin: 0, end: 1);
    CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = tween.animate(curve);
    controller.addListener(() {
      if (controller.isCompleted) {
        recordStats();
        spinning = false;
        setState(() {});
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6 + 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        // width: 200,
                        child: Image.asset(
                          "assets/win.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "You Won \$ $earnedValue",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                // content: Text(state.accessCode),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            });
      }
      if (controller.isAnimating) {
        print(" controller value angle ${controller.value}  -> $angle");
      }
    });
  }

  recordStats() {
    print(
        "___________randomSectorIndex ->  $randomSectorIndex ____________________");
    print("___________angle ->  $angle ____________________");
    earnedValue = sectors[sectors.length - (randomSectorIndex + 1)];
    // earnedValue = sectors[randomSectorIndex];
    totalEarnings = earnedValue;
    spins++;
  }

  generateSectorRadions() {
    double sectorRadion = 2 * math.pi / sectors.length;

    for (int i = 0; i < sectors.length; i++) {
      print("-----sectorRadion-> $i -> $sectorRadion-----------------");
      sectorRadians.add((i + 1) * sectorRadion);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: _body(),
      //floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
  }

  Widget _body() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/bg.jpg",
            ),
            fit: BoxFit.cover),
      ),
      child: _gameContent(),
    );
  }

  Widget _gameContent() {
    return Stack(
      children: [
        _gameTitle(),
        _gameWheel(),
        //  _gameActions(),
        _gameStats(),
      ],
    );
  }

  Widget _gameStats() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            "Total Earnings: $totalEarnings",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Spins: $spins",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gameTitle() {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Text(
        "Fortune Wheel ",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _gameWheel() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 5),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/belt.png"),
          fit: BoxFit.contain,
        )),
        child: InkWell(
          onTap: (() {
            setState(() {
              if (!spinning) {
                spin();
              }
            });
          }),
          child: AnimatedBuilder(
            animation: animation,
            builder: ((context, child) {
              return Transform.rotate(
                angle: controller.value * angle,
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/wheel.png"),
                    fit: BoxFit.cover,
                  )),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  spin() {
    randomSectorIndex = random.nextInt(sectors.length);

    double randomRadian = generateRandomRadianToSpinTo();
    controller.reset();
    angle = randomRadian;
    controller.forward();
  }

  generateRandomRadianToSpinTo() {
    // return (2 * math.pi * sectors.length) + sectorRadians[randomSectorIndex];
    return (2 * math.pi * sectors.length) + sectorRadians[randomSectorIndex];
  }
}
