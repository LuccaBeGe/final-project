import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextBox extends StatelessWidget {
  
  Color boxColor;
  String boxLabel;
  
  MyTextBox({required this.boxColor, required this.boxLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15, left: 7, right: 7),
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        width: MediaQuery.of(context).size.width/2.5,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(boxLabel, textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )
            ),
            )),
        ),
      ),
    );
  }
}