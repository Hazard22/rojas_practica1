import 'package:flutter/material.dart';

class Txtfield extends StatefulWidget {
  String lblText;
  var valor;

  Txtfield(this.lblText);

  @override
  State<Txtfield> createState() => _TxtfieldState();
}

class _TxtfieldState extends State<Txtfield> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) => setState(() {
                widget.valor = value;
              }),
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black)),
                labelText: widget.lblText,
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            )));
  }
}
