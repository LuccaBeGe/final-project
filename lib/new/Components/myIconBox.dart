// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyIconBox extends StatelessWidget {
  
  Color boxColor;
  String boxIcon;
  String boxLabel;
  
  MyIconBox({required this.boxColor, required this.boxIcon, required this.boxLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 55),
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        width: MediaQuery.of(context).size.width/2.5,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(15, 29, 74, 1),
            width: 2,
          ),
          color: boxColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              boxIcon,
              height: (MediaQuery.of(context).size.width/5)*0.8,
              width: (MediaQuery.of(context).size.width/5)*0.8,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
              textAlign: TextAlign.center,
              boxLabel, 
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: (MediaQuery.of(context).size.width/26),
                  fontWeight: FontWeight.w500
                )
              )),
            ),
          ],
        ),
      ),
    );
  }
}