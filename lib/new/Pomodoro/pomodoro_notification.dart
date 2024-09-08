import 'package:awesome_notifications/awesome_notifications.dart';


class NotificationCenter
{
  static String tempo = '';
  static int ciclos = 0;
  static List<String> estado = ['Estude', 'Descanse'];
  static bool lilBreak = false;

  static bool notificationStateController =  false;


  
  static CreatePomodoroNotification()
  {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 0, 
      channelKey: 'method_notification',
      title: '${Emojis.time_alarm_clock} ' + 'Timer pomodoro, Ciclo: ${ciclos}' + ' ${Emojis.food_tomato}', 
      body: '${lilBreak == false ? estado[0] : estado[1]}',
      notificationLayout: NotificationLayout.Default,
    )
  );
  }

  static Future<void> DismissPomodoroNotification() async
  {
    await AwesomeNotifications().dismiss(0);
  }


}