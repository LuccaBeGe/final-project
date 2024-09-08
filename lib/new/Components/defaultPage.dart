// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultPage extends StatelessWidget {
  
  String texto;
  
  DefaultPage({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              Center( 
                child: Image.asset(
                'Assets/Imgs/background/backgournd.jpg',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                ),
              ),
              Container(
              height: MediaQuery.of(context).size.height/5,
              width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 29, 74, 1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              child: Center(child: Text(
                texto, 
                textAlign: TextAlign.center,
                softWrap: true,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width/13,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
            ), 
            texto == 'Seja bem-vindo!' ? Container() : 
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white,)),
                  ],
                ),
              )
          ],
        );
  }
}