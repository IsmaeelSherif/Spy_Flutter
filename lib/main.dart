import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}


class Screen extends StatelessWidget {

  String numOfPlayersString, numOfSpyText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 70),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 70,
                width: 100,
                child: TextField(
                  onChanged: (value){
                    numOfPlayersString = value;
                  },
                ),
              ),

              SizedBox(
                height: 70,
                width: 100,
                child: TextField(
                  onChanged: (value){
                    numOfSpyText = value;
                  },
                ),
              ),

              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) => Game(int.parse(numOfPlayersString), int.parse(numOfSpyText)),
                  ));
                },
                child: Text("Start"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Game extends StatefulWidget {

  final int numOfPlayers, numOfSpy;

  Game(this.numOfPlayers, this.numOfSpy);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  List<String> list = [];
  String enteredText = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 70),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("${list.length+1} / ${widget.numOfPlayers}"),

              SizedBox(
                height: 70,
                width: 100,
                child: TextField(
                  controller: controller,
                  onChanged: (value){
                    enteredText = value;
                  },
                ),
              ),

              TextButton(
                onPressed: (){
                  list.add(enteredText);
                  controller.text = "";

                  if(list.length == widget.numOfPlayers){
                    print(list.length);
                    print(widget.numOfPlayers);
                    print(widget.numOfSpy);
                    Navigator.pushReplacement(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) => SpyGame(widget.numOfPlayers, widget.numOfSpy, list),
                    ));
                    return;
                  }
                  setState(() {

                  });
                },
                child: Text("Next"),
              )

            ],
          ),
        ),
      ),
    );
  }
}


class SpyGame extends StatefulWidget {

  final List<String> places;
  final int numOfPlayers, numOfSpy;

  SpyGame(this.numOfPlayers, this.numOfSpy, this.places);

  @override
  _SpyGameState createState() => _SpyGameState();
}

class _SpyGameState extends State<SpyGame> {

  int currentPlayerIndex, tempIndex;
  List<String> results = [];

  @override
  void initState() {

    List spies = [];
    while(true){
      int lol = Random().nextInt(widget.numOfPlayers);
      if(!spies.contains(lol)) {
        spies.add(lol);
        if (spies.length == widget.numOfSpy) {
          break;
        }
      }
    }
    int placeIndex = Random().nextInt(widget.places.length);
    while(spies.contains(placeIndex)){
      placeIndex = Random().nextInt(widget.places.length);
    }
    String place = widget.places[placeIndex];
    results = List.generate(widget.numOfPlayers, (index) {
      return place;
    });

    for(int i = 0; i < spies.length; i++){
      results[spies[i]] = "Spy";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if(currentPlayerIndex == results.length){
      return Container();
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              currentPlayerIndex != null? Text("Player ${currentPlayerIndex+1} / ${widget.numOfPlayers}") : SizedBox.shrink(),

              currentPlayerIndex != null?
              Text(results[currentPlayerIndex], style: TextStyle(fontSize: 30),) :
              Text("Pass the device to next player", style: TextStyle(fontSize: 30),),


              TextButton(
                onPressed: (){
                  setState(() {
                    if(currentPlayerIndex == null && tempIndex == null){
                      currentPlayerIndex = 0;
                      return;
                    }
                    if(currentPlayerIndex == null){
                      currentPlayerIndex = tempIndex;
                      print(tempIndex);
                      currentPlayerIndex++;
                    }
                    else {
                      tempIndex = currentPlayerIndex;
                      currentPlayerIndex = null;
                    }

                  });

                },
                child: Text("Next"),
              )

            ],
          ),
        ),
      ),
    );
  }
}


