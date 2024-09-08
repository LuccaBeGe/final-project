// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace


import 'package:flutter/material.dart';
import 'package:tcc/new/Components/defaultPage.dart';
import 'package:tcc/new/Components/instructionsRepository.dart';
import 'package:tcc/new/Components/myIconBox.dart';
import 'package:tcc/new/Components/myPopUpBox.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';

class InstrucoesView extends StatefulWidget {

  @override
  State<InstrucoesView> createState() => _InstrucoesViewState();
}

class _InstrucoesViewState extends State<InstrucoesView> {
  
  String popText = '';

   @override
   void initState() {
    super.initState();
    // Configura o callback para fechar a pop-up
    ShowingBoxControl.onClose = () {
      setState(() {
        ShowingBoxControl.Unpop();
      });
    };
  }

  void _showPopUp(String texto)
  {
    setState(() {
        popText = texto;
        ShowingBoxControl.pop();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !ShowingBoxControl.isPoped,
      onPopInvoked: (didPop)
      {
        if(ShowingBoxControl.isPoped)
        {
          setState(() {
            ShowingBoxControl.Unpop();
          });
        }
      },
      child: Scaffold(
        body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    DefaultPage(texto: 'Instruções'),
                    Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height/4.4),
                        Center(
                          child: InkWell(
                            child: MyIconBox(
                              boxColor: Colors.white,
                              boxIcon: 'Assets/Imgs/icons/Icon_pomodoro.png',
                              boxLabel: 'Pomodoro',
                            ),
                          onTap: ()
                          {
                            _showPopUp((InstrucionBook.instrucoes['pomodoro']).toString());
                          },
                          ),
                        ),
                        Center(
                          child: InkWell(
                            child: MyIconBox(
                              boxColor: Colors.white,
                              boxIcon: 'Assets/Imgs/icons/Icon_ondas.png',
                              boxLabel: 'Ondas Binaurais',
                            ),
                          onTap: ()
                          {
                            _showPopUp((InstrucionBook.instrucoes['ondas']).toString());
                          },
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              _showPopUp((InstrucionBook.instrucoes['Eisenhower']).toString());
                            },
                            child: MyIconBox(
                              boxColor: Colors.white,
                              boxIcon: 'Assets/Imgs/icons/Icon_eisenhoer.png',
                              boxLabel: 'Matriz de Eisenhower',
                            ),
                          ),
                        )
                      ],
                    ),
                    if(ShowingBoxControl.isPoped)
                    PopUpBox(texto: popText),
                  ],
                )
              )
      ),
    );
  }
}