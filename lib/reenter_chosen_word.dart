import 'package:flutter/material.dart';
import 'package:spy_fall/number_picker.dart';
import 'package:spy_fall/spy_game.dart';

class ReEnterChosenWord extends StatefulWidget {

  final int placeIndex;
  final List<String> places;

  ReEnterChosenWord(this.placeIndex, this.places);

  @override
  _ReEnterChosenWordState createState() => _ReEnterChosenWordState();
}

class _ReEnterChosenWordState extends State<ReEnterChosenWord> {

  int numOfSpies = 1;
  String enteredText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Let Player ${widget.placeIndex + 1} choose another thing",
              style: TextStyle(
                fontSize: 20
              ),
            ),

            SizedBox(
              height: 70,
              width: 100,
              child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (newVal){
                  enteredText = newVal;
                },
              ),
            ),

            SizedBox(height: 40),

            Picker(
              text: "Number of Spies",
              start: 1,
              end: widget.places.length - 1,
              value: numOfSpies,
              onChanged: (newVal){
                setState(() {
                  numOfSpies = newVal;
                });
              },
            ),

            SizedBox(height: 40),

            TextButton(
              onPressed: (){

                if(enteredText != null && enteredText.isNotEmpty && !enteredText.toLowerCase().contains("spy")){
                  widget.places[widget.placeIndex] = enteredText;

                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) => SpyGame(numOfSpies, widget.places),
                  ));

                }

              },
              child: Text("Start"),
            )

          ],
        ),
      ),
    );
  }
}
