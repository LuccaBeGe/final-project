import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayingTrack extends StatefulWidget {
  
  String img = '';
  String track = '';
  
  PlayingTrack({required this.img, required this.track});

  @override
  State<PlayingTrack> createState() => _PlayingTrackState();
}

class _PlayingTrackState extends State<PlayingTrack> {
  
   late AssetsAudioPlayer _assetsAudioPlayer;
   Duration currentTime = Duration(seconds: 0);
   Duration totalDuration = Duration(seconds: 0);
   bool musicState = false;
   
   StreamSubscription? position_listener;
   StreamSubscription? duration_listener;

  @override
  void initState() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.open(
      Audio(
        widget.track,
        metas: Metas(
          title: 'Ondas Binaurais para foco',
          image: MetasImage.asset(widget.img),
        ),
      ),
      autoStart: false,
      showNotification: false,
      volume: 1,
    ).then((_){
      _assetsAudioPlayer.setVolume(1);
    });
    position_listener = _assetsAudioPlayer.currentPosition.listen((newPosition)
    {
      
      setState(() {
        currentTime = newPosition;
        musicState = _assetsAudioPlayer.isPlaying.value;
      });
      if(totalDuration.inSeconds == currentTime.inSeconds)
        {
          
          setState(() {
            currentTime = Duration(seconds: 0);
            _assetsAudioPlayer.pause();
            _assetsAudioPlayer.seek(currentTime);
            musicState = false;
          });
        }
    });
    
    duration_listener = _assetsAudioPlayer.onReadyToPlay.listen((audio) {
    setState(() {
      totalDuration = audio!.duration;
    });
    });
    super.initState();
  }

  @override
  void dispose() {
    position_listener!.cancel();
    duration_listener!.cancel();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: 
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset(
                'Assets/Imgs/background/backgournd.jpg',
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 fit: BoxFit.cover,
                ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Stack(
                  children: [
                   Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.img,
                        width: 350,
                        height: MediaQuery.of(context).size.height/1.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.5, left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.498),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 350,
                              height: MediaQuery.of(context).size.height/7,
                            ),
                          ),
                        ),
                        Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.7),
                          child: StreamBuilder(
                            stream: _assetsAudioPlayer.currentPosition,
                            builder: (context, snapshot)
                            { return Slider(
                              activeColor: Colors.yellow,
                              min: 0,
                              max: totalDuration.inSeconds.toDouble(),
                              value: currentTime.inSeconds.toDouble(),
                              onChanged: (value) async {
                                setState(() {
                                  currentTime = Duration(seconds: value.toInt());
                                });
                                _assetsAudioPlayer.seek(currentTime);
                              });
                            }
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 70,
                              child: Text(formatTime(
                                currentTime
                              ),
                              style: GoogleFonts.montserrat(
                                color: Colors.yellowAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25,),
                              child: InkWell(
                                onTap: () {
                                  if(!musicState)
                                  { 
                                    setState(() {
                                      musicState = true;
                                      position_listener!.resume();
                                      _assetsAudioPlayer.play();
                                    });
                                  } else
                                  {
                                    
                                    setState(() {
                                      position_listener!.pause();
                                      musicState = false;
                                    });
                                    _assetsAudioPlayer.pause();
                                  }
                                },
                                child: Image.asset(
                                  musicState == true ? 
                                  'Assets/Imgs/icons/pause_track_icon.png' :
                                  'Assets/Imgs/icons/play_track_icon.png',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: Text(formatTime(
                                (totalDuration),
                              ),
                              style: GoogleFonts.montserrat(
                                color: Colors.yellowAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),),
                            )
                          ],
                        )
                      ),
                    )
                    ]),
                  ),
                  ]
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTime(Duration duration)
{
  String twoDigits(int n)=>n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if(duration.inHours > 0) 
    hours,
    minutes,
    seconds,
  ].join(':');
} 