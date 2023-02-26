import 'package:flutter/material.dart';

class PassTxtFields extends StatefulWidget {
  String lblText;
  var valor;

  PassTxtFields(this.lblText);

  @override
  State<PassTxtFields> createState() => _TxtfieldState();
}

class _TxtfieldState extends State<PassTxtFields> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
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
