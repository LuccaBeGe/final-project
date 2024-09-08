import 'package:flutter/material.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';

class MethodsDefault extends StatelessWidget {


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
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back),
              ),
              InkWell(
                onTap: () {
                  ShowingBoxControl.feltOpening();
                },
                child: Image.asset(
                  'Assets/Imgs/icons/Icon_ajuda.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )
      ]
      
    
    );
  }
}