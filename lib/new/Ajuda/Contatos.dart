// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tcc/new/Components/defaultPage.dart';
import 'package:google_fonts/google_fonts.dart';

class ContatosView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  DefaultPage(texto: 'Contatos'),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/5),
                      InfoRectangle(
                        email: '21000258@liberato.com.br',
                        numero: '(51) 9 9397-5748'
                      ),
                      InfoRectangle(
                        email: '21000265@liberato.com.br',
                        numero: '(51) 9 9374-4220'
                      ),
                    ],
                  )                
                ]
              )
            )
          );
  }
}

class InfoRectangle extends StatelessWidget {
  
  String email, numero;
  
  InfoRectangle({required this.email, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8, left: 8, top: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(15, 29, 74, 1),
            width: 2,
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Email:', 
                  style: GoogleFonts.montserrat
                      (
                        textStyle:TextStyle(
                          color: Color.fromRGBO(54, 54, 54, 1.0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ) 
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(15, 29, 74, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(211, 227, 224, 1), 
                      ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3, right: 6, left: 6),
                      child: Text(
                        email,
                        style: GoogleFonts.montserrat
                        (
                          textStyle:TextStyle(
                            color: Color.fromRGBO(54, 54, 54, 1.0),
                            fontSize: 15,
                          ) 
                        )
                        ),
                    ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Número:',
                  style: GoogleFonts.montserrat
                      (
                        textStyle:TextStyle(
                          color: Color.fromRGBO(54, 54, 54, 1.0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ) 
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(15, 29, 74, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(211, 227, 224, 1), 
                      ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3, right: 6, left: 6),
                      child: Text(numero,
                      style: GoogleFonts.montserrat
                        (
                          textStyle:TextStyle(
                            color: Color.fromRGBO(54, 54, 54, 1.0),
                            fontSize: 15,
                          ) 
                        )),
                    ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
