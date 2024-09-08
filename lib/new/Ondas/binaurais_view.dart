
import 'package:flutter/material.dart';
import 'package:tcc/new/Components/instructionsRepository.dart';
import 'package:tcc/new/Components/methodsDefaultPage.dart';
import 'package:tcc/new/Components/myPopUpBox.dart';
import 'package:tcc/new/Eisen/eisen_notification.dart';
import 'package:tcc/new/Ondas/playingTrack_view.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';
import 'package:tcc/new/controller/retainer.dart';

class BinauralBeatsView extends StatefulWidget {
  const BinauralBeatsView({super.key});

  @override
  State<BinauralBeatsView> createState() => _BinauralBeatsViewState();
}

class _BinauralBeatsViewState extends State<BinauralBeatsView> {
  
  @override
  void initState() {
    CancelSchedules();
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
    _validateFirstTime().then((isFirstTime)
    { 
      if(isFirstTime == true)
      {
        ShowingBoxControl.feltOpening();
        validateFirsTime((!isFirstTime), 'ondas');
      }
    });
    super.initState();
  }

  Future<bool> _validateFirstTime() async
  {
    bool? isFirstTemp = await ValidatedFirstTime('ondas');

    return isFirstTemp ?? true;
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
              MethodsDefault(),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, 
                top: MediaQuery.of(context).size.height/8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: TrackSelection(
                        img: 'Assets/Imgs/thumbs/chuva_thumb.jpg',
                        track: 'Assets/tracks/Binaural_1.mp3',
                      ),
                    ),
                    SizedBox(
                      child: TrackSelection(
                        img: 'Assets/Imgs/thumbs/mar_thumb.jpg',
                        track: 'Assets/tracks/Binaural_2.mp3',
                      ),
                    ),
                    SizedBox(
                      child: TrackSelection(
                        img: 'Assets/Imgs/thumbs/floresta_thumb.jpg',
                        track: 'Assets/tracks/Binaural_3.mp3',
                      ),
                    )
                  ],
                ),
              ),
              if(ShowingBoxControl.isPoped)
              PopUpBox(texto: (InstrucionBook.instrucoes['ondas']).toString())
            ],
          ),
        ),
      ),
    );
  }
}

class TrackSelection extends StatelessWidget {
  
  String img = '';
  String track = '';
  
  TrackSelection({required this.img, required this.track});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 7, bottom: 
      MediaQuery.of(context).size.height/15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              height: MediaQuery.of(context).size.height/5.5,
              width: MediaQuery.of(context).size.width/1.8,
              fit: BoxFit.fill,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayingTrack(
                img: img,
                track: track,
              )));
            },
            child: Image.asset(
              'Assets/Imgs/icons/play_icon.png',
                height: MediaQuery.of(context).size.height/6.5,
                width: MediaQuery.of(context).size.width/3.2,
                fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}