// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tcc/new/navigation_view.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/ic_alarm_on',
    [
      NotificationChannel(
        channelKey: 'method_notification',
        channelName: 'Notificações Pomodoro',
        channelDescription: 'A cada começo do timer indica em qual ciclo e estado(estudar, descansar), está sendo executado',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_notification',
        channelName: 'Notificações Eisenhower',
        channelDescription: 'Alerta sobre a tarefa de maior prioridade pendente',
        importance: NotificationImportance.High,
        locked: true
      ) 
    ]
  );
  runApp(AppTcc());
}

class AppTcc extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context) => NavigationView(),
    }
       );
  }
}
