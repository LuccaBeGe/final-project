// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/new/Components/instructionsRepository.dart';
import 'package:tcc/new/Components/methodsDefaultPage.dart';
import 'package:tcc/new/Components/myPopUpBox.dart';
import 'package:tcc/new/Eisen/eisen_notification.dart';
import 'package:tcc/new/Pomodoro/pomodoro_notification.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';
import 'package:tcc/new/controller/retainer.dart';


class PomodoroMethod extends StatefulWidget {
  

  @override
  State<PomodoroMethod> createState() => _PomodoroMethodState();
}

class _PomodoroMethodState extends State<PomodoroMethod> with 
TickerProviderStateMixin{
  
  late AnimationController controller;

  String get CountText{
      Duration count = controller.duration! * controller.value;
      return controller.isDismissed? 
      '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
      :'${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }


  bool isPalying = false;
  bool isShortBreak = false;
  double progress = 1.0;
  bool stop = false;
  bool pause = false;
  late Future<int> initialSecondsFuture;
  Duration pomodoroConfiguration = Duration(seconds: 0);

  Future<int> savedPomodoro() async
  {
    int seconds = await GetPomodoroTime('pomodoro');
    pomodoroConfiguration = Duration(seconds: seconds);
    return seconds;
  }
  
  int breakSeconds = 600; 
  int ciclos = 0;


  @override
  void initState(){
    CancelSchedules();
    super.initState();
    initialSecondsFuture = savedPomodoro();
    ShowingBoxControl.onClose = ()
    {
      setState(() {
        ShowingBoxControl.Unpop();
      });
    };
    ShowingBoxControl.onOpen = ()
    {
      setState(() {
        ShowingBoxControl.pop();
      });
    };
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: pomodoroConfiguration.inSeconds));
      controller.addStatusListener((status){
      if(status == AnimationStatus.dismissed && isShortBreak == false && stop == false)
      {
        setState(() {
          isShortBreak = true;
          isPalying = true;
          
          progress = 1.0;
          controller.duration = Duration(seconds: breakSeconds);
          controller.reverse(
          from: controller.value == 0? 1.0: controller.value);
          NotificationCenter.notificationStateController = false;
        });
      }else if(status == AnimationStatus.dismissed && isShortBreak && stop == false)
      {
        setState(() {
          isShortBreak = false;
          progress = 1.0;
          controller.duration = Duration(seconds: pomodoroConfiguration.inSeconds);
          ciclos++;
          if(ciclos < 3)
          {
          NotificationCenter.notificationStateController = false;
          controller.reverse(
          from: controller.value == 0? 1.0: controller.value);
          }
          else if(ciclos >= 3)
          {
             NotificationCenter.lilBreak = false;
            NotificationCenter.DismissPomodoroNotification();
            NotificationCenter.notificationStateController = false;
            isPalying = false;
            ciclos = 0;
          }
          
        });
      } else if(status == AnimationStatus.dismissed && stop == true)
      {
        setState(() {
          ciclos = 0;
          controller.duration = Duration(seconds: pomodoroConfiguration.inSeconds);
          isShortBreak = false;
          isPalying = false;
          controller.reset();
        });
      };
    });
    /*controller.addListener((){
      if(isPalying)
      {
        setState(() {
          progress = controller.value;
        });
      }else
      {
        setState(() {
          progress = 1.0;
        });
      }
    });*/
    _validateFirstTime().then((isFirstTime)
    {
      if(isFirstTime == true)
      {
        ShowingBoxControl.feltOpening();
        validateFirsTime((!isFirstTime), 'pomodoroFirst');
      }
    });
    
  }

  Future<bool> _validateFirstTime() async
  {
    bool? isFirstTemp = await ValidatedFirstTime('pomodoroFirst');

    return isFirstTemp ?? true;
  }
  
  @override
  void dispose() {
    controller.dispose();
    NotificationCenter.DismissPomodoroNotification();
    NotificationCenter.notificationStateController = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: initialSecondsFuture,  // Use the Future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  // Show a loading indicator while waiting
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));  // Show error message if there's an error
        } else if (snapshot.hasData) {
          // Initialize controller with the loaded data
          final int initialSeconds = snapshot.data!;
          if(!isShortBreak)
          {
           controller.duration = Duration(seconds: initialSeconds);
          }
          else
          {
            controller.duration = Duration(seconds: breakSeconds);
          }
          if(pomodoroConfiguration != controller.duration && !isShortBreak)
          {
            controller.duration = pomodoroConfiguration;
          }

          return PopScope(
            canPop: !ShowingBoxControl.isPoped,
            onPopInvoked: (didPop) {
              if (ShowingBoxControl.isPoped) {
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
                    MethodsDefault(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50, bottom: 70),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(150),
                                ),
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(15, 29, 74, 1),
                                  backgroundColor: Colors.grey.shade300,
                                  strokeWidth: 6,
                                  value: progress,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.isDismissed) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        height: MediaQuery.of(context).size.height / 3,
                                        child: CupertinoTimerPicker(
                                          initialTimerDuration: controller.duration!,
                                          onTimerDurationChanged: (time) {
                                            setState(() {
                                              controller.duration = time;
                                              pomodoroConfiguration = time;
                                              SavePomodoroTime(pomodoroConfiguration.inSeconds, 'pomodoro');
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (context, build) {
                                    controller.addListener((){
                                      if(isPalying)
                                      {
                                        setState(() {
                                          progress = controller.value;
                                        });
                                      }else
                                      {
                                        setState(() {
                                          progress = 1.0;
                                        });
                                      }
                                    });
                                    if (isPalying) {
                                      NotificationCenter.tempo = CountText;
                                      NotificationCenter.ciclos = ciclos + 1;
                                      NotificationCenter.lilBreak = isShortBreak;
                                      if (!NotificationCenter.notificationStateController) {
                                        NotificationCenter.CreatePomodoroNotification();
                                        NotificationCenter.notificationStateController = true;
                                      }
                                    }
                                    return Text(
                                      CountText,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width/6,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    stop = false;
                                  });
                                  if (controller.isAnimating) {
                                    pause = true;
                                    controller.stop();
                                    setState(() {
                                      isPalying = false;
                                    });
                                  } else {
                                    pause = false;
                                    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
                                    setState(() {
                                      isPalying = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: isPalying == true
                                      ? Image.asset(
                                          'Assets/Imgs/icons/pause_icon.png',
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          'Assets/Imgs/icons/play_icon.png',
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    NotificationCenter.DismissPomodoroNotification();
                                    NotificationCenter.notificationStateController = false;
                                    stop = true;
                                    controller.reset();
                                    progress = 1.0;
                                    controller.duration = pomodoroConfiguration;
                                  });
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'Assets/Imgs/icons/stop_icon.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (ShowingBoxControl.isPoped)
                      PopUpBox(texto: (InstrucionBook.instrucoes['pomodoro']).toString())
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text('Nenhum dado disponível'));  // Handle the case where there's no data
        }
      },
    );
  }
}