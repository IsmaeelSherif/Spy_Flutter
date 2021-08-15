import 'package:flutter/material.dart';
import 'package:spy_fall/spy_game.dart';

class WordsSetupScreen extends StatefulWidget {

  final int numOfPlayers, numOfSpy;

  WordsSetupScreen(this.numOfPlayers, this.numOfSpy);

  @override
  _WordsSetupScreenState createState() => _WordsSetupScreenState();
}

class _WordsSetupScreenState extends State<WordsSetupScreen> {

  List<String> list = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("${list.length+1} / ${widget.numOfPlayers}"),

            SizedBox(
              height: 70,
              width: 200,
              child: TextField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
                maxLength: 20,
              ),
            ),

            SizedBox(height: 80),

            TextButton(
              onPressed: (){
                String enteredText = controller.text.trim();

                if(enteredText != null && enteredText.isNotEmpty && !enteredText.toLowerCase().contains("spy")){
                  list.add(enteredText);
                }

                controller.text = "";

                if(list.length == widget.numOfPlayers){
                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) => SpyGame(widget.numOfSpy, list),
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
    );
  }
}