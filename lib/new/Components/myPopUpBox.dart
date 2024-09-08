// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';

class PopUpBox extends StatelessWidget {
  
  String texto;
  
  PopUpBox({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ 
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(54, 54, 54, 0.6),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/10),
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 5, top: 15, bottom: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(30),
                        child: Text(texto, style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 5, top: 15, bottom: 15),
                  child: InkWell(
                    onTap: () {
                      ShowingBoxControl.feltAnimation();
                    },
                    child: Container(
                      height: 50,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text('Entendi', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),)
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    ]);
  }
}