

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tcc/new/controller/esienhower_controller.dart';

Future<void> CriarNotificacaoLembrarTarefa(List<int> iconStates, List<String> tarefas) async {
  late String tarefaPendente;
  int i = 0;
  bool flag = false;

  // Se não houver tarefas pendentes, saia da função
  if (tarefas.isEmpty) {
    CancelSchedules();
    return;
  }

  // Encontre a tarefa pendente
  while (i < iconStates.length && !flag) {
    if (iconStates[i] == 0) {
      tarefaPendente = tarefas[i];
      flag = true;
    }
    i++;
  }

  int hoursControl = 0;
  do
  {
    EisenhowerMatrix.uI.forEach((element)
    {
      if(element == tarefaPendente)
      {
        hoursControl = 3600; // de hora em hora
      }
    });
    EisenhowerMatrix.nI.forEach((element)
    {
      if(element == tarefaPendente)
      {
        hoursControl = 10800; // 3 horas em 3 horas
      }
    });
    EisenhowerMatrix.uN.forEach((element)
    {
      if(element == tarefaPendente)
      {
        hoursControl = 21600; //5 horas em 5 horas
      }
    });
    EisenhowerMatrix.nN.forEach((element)
    {
      if(element == tarefaPendente)
      {
        hoursControl = 1; //nunca notificar
      }
    });

    if (!flag || hoursControl == 1) {
      CancelSchedules();
      return;
    }

  } while(hoursControl == 0);
  // Crie a notificação
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'scheduled_notification',
      title: '${Emojis.transport_police_car_light} Você tem uma tarefa pendente ${Emojis.transport_police_car_light}',
      body: tarefaPendente,
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: 
    NotificationInterval(
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      interval: hoursControl,
      repeats: true,
    ),
  );
}

Future<void> CancelSchedules() async
{
  await AwesomeNotifications().cancelAllSchedules();
}