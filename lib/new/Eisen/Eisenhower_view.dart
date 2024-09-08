import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/new/Eisen/eisen_notification.dart';
import 'package:tcc/new/controller/esienhower_controller.dart';
import 'package:tcc/new/Components/listaToDo_view.dart';
import 'package:tcc/new/Components/instructionsRepository.dart';
import 'package:tcc/new/Components/methodsDefaultPage.dart';
import 'package:tcc/new/Components/myPopUpBox.dart';
import 'package:tcc/new/Components/myTextBox.dart';
import 'package:tcc/new/Eisen/lista_controller.dart';
import 'package:tcc/new/controller/popUpBox_controller.dart';
import 'package:tcc/new/controller/retainer.dart';

class EisenhowerView extends StatefulWidget {

  @override
  State<EisenhowerView> createState() => _EisenhowerViewState();
}

class _EisenhowerViewState extends State<EisenhowerView> {

  List<String> listaEisen = [];

  @override
  void initState() {
    super.initState();
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
    ListaToDoControl.updateList = () async {
      await _updateListaEisen();
    };
    _updateListaEisen();
     _validateFirstTime().then((isFirstTime)
    {
  
      if(isFirstTime == true)
      {
        ShowingBoxControl.feltOpening();
        validateFirsTime((!isFirstTime), 'eisen');
      }
    });
  }

  Future<bool> _validateFirstTime() async
  {
    bool? isFirstTemp = await ValidatedFirstTime('eisen');

    return isFirstTemp ?? true;
  }

  Future<void> _updateListaEisen() async {
    await EisenhowerMatrix.setMatrizEisenhower();
    setState(() {
      listaEisen = EisenhowerMatrix.getMatrizEisenhower;
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
            Recipient.saveStates(Recipient.theStates,Recipient.tarefas);
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
                children: [ 
                  SizedBox(
                  height: MediaQuery.of(context).size.height/1.8,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/10, 
                      bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder:(context) => AdicionarTarefasView(
                                  importancia: 0,
                                  urgencia: 0,
                                  texto: 'Urgente e Importante',
                                )));
                              },
                              child: MyTextBox(
                                boxColor: Color.fromRGBO(0, 191, 63, 1), 
                                boxLabel: 'Urgente e Importante'
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder:(context) => AdicionarTarefasView(
                                  importancia: 0,
                                  urgencia: 1,
                                  texto: 'Não Urgente e Importante',
                                )));
                              },
                              child: MyTextBox(
                                boxColor: Color.fromRGBO(0, 122, 191, 1), 
                                boxLabel: 'Não Urgente e Importante'
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder:(context) => AdicionarTarefasView(
                                  importancia: 1,
                                  urgencia: 0,
                                  texto: 'Urgente e Não Importante',
                                )));
                              },
                              child: MyTextBox(
                                boxColor: Color.fromRGBO(237, 92, 19, 1), 
                                boxLabel: 'Urgente e \nNão importante'
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                builder:(context) => AdicionarTarefasView(
                                  importancia: 1,
                                  urgencia: 1,
                                  texto: 'Não Urgente e Não Importante',
                                )));
                              },
                              child: MyTextBox(
                                boxColor: Color.fromRGBO(255, 31, 31, 1), 
                                boxLabel: 'Não Urgente e Não Importante'
                              ),
                            )
                          ],
                        ),
                      ],
                    ), 
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [ 
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(15, 29, 74, 1),
                            width: 4,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25), 
                            topRight: Radius.circular(25))
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lista de afazeres:',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              )
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: 
                                  ListaToDo(EisenToDo: listaEisen), //view da lista To-do
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Center(
                                child: InkWell(
                                  onTap: ()
                                  {
                                    CancelSchedules();
                                    setState((){
                                      EisenhowerMatrix.cleanMatrizEisenhower();
                                      ListaToDo(EisenToDo: EisenhowerMatrix.getMatrizEisenhower);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(15, 29, 74, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: 
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Reiniciar Lista',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700
                                        )
                                      ),
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ]),
                )
              ]),
              if(ShowingBoxControl.isPoped)
              PopUpBox(texto: (InstrucionBook.instrucoes['Eisenhower']).toString())
            ],
          ),
        )
      ),
    );
  }
}