// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

//import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tcc/new/Ajuda/ajuda_view.dart';
import 'package:tcc/new/Components/defaultPage.dart';
import 'package:tcc/new/Components/myIconBox.dart';
import 'package:tcc/new/Eisen/Eisenhower_view.dart';
import 'package:tcc/new/Ondas/binaurais_view.dart';
import 'package:tcc/new/Pomodoro/pomodoro_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed)
      {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text('Notificações'),
            content: Text('Alguns métodos fazem o uso de notificações'),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text(
                  'Não permitir',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),)
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  AwesomeNotifications().requestPermissionToSendNotifications();
                },
                child: Text(
                  'Permitir',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),)
              )
            ],
          ));
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  DefaultPage(texto: 'Seja bem-vindo!'),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/3.3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PomodoroMethod()));
                            },
                            child: MyIconBox(
                              boxColor: Colors.white, 
                              boxIcon: 'Assets/Imgs/icons/Icon_pomodoro.png', 
                              boxLabel: 'Pomodoro'
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BinauralBeatsView()));
                            },
                            child: MyIconBox(
                              boxColor: Colors.white, 
                              boxIcon: 'Assets/Imgs/icons/Icon_ondas.png', 
                              boxLabel: 'Ondas Binaurais'
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EisenhowerView()));
                            },
                            child: MyIconBox(
                              boxColor: Colors.white, 
                              boxIcon: 'Assets/Imgs/icons/Icon_eisenhoer.png', 
                              boxLabel: 'Matriz de Eisenhower'
                            ),
                          ),
                          InkWell(
                            onTap: ()
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AjudaView()));
                            },
                            child: MyIconBox(
                                boxColor: Colors.white, 
                                boxIcon: 'Assets/Imgs/icons/Icon_ajuda.png', 
                                boxLabel: 'Ajuda'
                              ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            )
    );
  }
}