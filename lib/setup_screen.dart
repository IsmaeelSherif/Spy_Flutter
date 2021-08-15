import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spy_fall/setup_words.dart';

import 'number_picker.dart';

class SetupScreen extends StatefulWidget {

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int numOfPlayers = 4, numOfSpies = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "New Game",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 100),

            Picker(
              text: "Number Of Players",
              start: 3,
              end: 50,
              value: numOfPlayers,
              onChanged: (int newValue) {
                setState(() {
                  numOfPlayers = newValue;
                  if(numOfPlayers <= numOfSpies){
                    numOfSpies = 1;
                  }
                });
              },
            ),

            SizedBox(height: 20),

            Picker(
              text: "Number Of Spies",
              start: 1,
              end: numOfPlayers - 1,
              value: numOfSpies,
              onChanged: (int newValue) {
                setState(() {
                  numOfSpies = newValue;
                });
              },
            ),

            SizedBox(height: 40),

            TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) => WordsSetupScreen(numOfPlayers, numOfSpies),
                ));
              },
              child: Text("Start", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}


