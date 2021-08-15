import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:spy_fall/setup_screen.dart';
import 'package:spy_fall/reenter_chosen_word.dart';

class SpyGame extends StatefulWidget {

  final List<String> places;
  final int numOfSpy;

  SpyGame(this.numOfSpy, this.places);

  @override
  _SpyGameState createState() => _SpyGameState();
}

class _SpyGameState extends State<SpyGame> {

  int currentPlayerIndex = -1;
  bool showResult = false;
  List<String> results = [];
  List<int> spiesIndexes = [];
  int numOfPlayers;
  int lastClickTime = 0;
  int placeIndex;

  @override
  void initState() {
    numOfPlayers = widget.places.length;

    while(true){
      int spyIndex = Random().nextInt(numOfPlayers);
      if(!spiesIndexes.contains(spyIndex)) {
        spiesIndexes.add(spyIndex);
        if (spiesIndexes.length == widget.numOfSpy) {
          break;
        }
      }
    }
    placeIndex = Random().nextInt(widget.places.length);
    while(spiesIndexes.contains(placeIndex)){
      placeIndex = Random().nextInt(widget.places.length);
    }
    String place = widget.places[placeIndex];
    results = List.generate(numOfPlayers, (index) {
      return place;
    });

    for(int i = 0; i < spiesIndexes.length; i++){
      results[spiesIndexes[i]] = "Spy";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget child;

    if(currentPlayerIndex == numOfPlayers - 1 && !showResult){
      child = Align(
        alignment: Alignment.lerp(Alignment.topCenter, Alignment.center, 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) => ReEnterChosenWord(placeIndex, widget.places),
                ));
              },
              child: Text(
                'Next Round',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),

            SizedBox(height: 50),

            TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) => SetupScreen(),
                ));
              },
              child: Text(
                'New Game',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ],
        ),
      );
    }

    else{
      child = Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            showResult? Text("Player ${currentPlayerIndex+1} / $numOfPlayers") : SizedBox.shrink(),

            SizedBox(height: 40),

            showResult?
            Text(results[currentPlayerIndex], style: TextStyle(fontSize: 30),) :
            Text("Pass the device to\nPlayer ${currentPlayerIndex + 2}", style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),

            SizedBox(height: 80),

            TextButton(
              onPressed: (){
                if(DateTime.now().millisecondsSinceEpoch - lastClickTime < 1000){
                  return;
                }
                lastClickTime = DateTime.now().millisecondsSinceEpoch;

                setState(() {
                  showResult = !showResult;
                  if(showResult && currentPlayerIndex == -1){
                    currentPlayerIndex++;
                    return;
                  }
                  if(showResult && currentPlayerIndex != -1){
                    currentPlayerIndex++;
                  }
                });
              },
              child: Text("Next"),
            )

          ],
        ),
      );
    }

    return Scaffold(
      body: child,
    );
  }
}