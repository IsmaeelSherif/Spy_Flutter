import 'package:flutter/material.dart';

class Picker extends StatefulWidget {

  final String text;
  int value;
  final Function onChanged;
  final int start, end;

  Picker({@required this.text, @required this.onChanged, @required this.value, this.start, this.end});

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [

        Text(
          widget.text,
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),


        SizedBox(width: 50),

        SizedBox(
          width: 50,
          child: DropdownButton<int>(
            isExpanded: true,
            value: widget.value,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: widget.onChanged,
            items: List.generate(widget.end - widget.start + 1, (index) => index + widget.start)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Center(child: Text(value.toString())),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}