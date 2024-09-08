import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/new/Eisen/eisen_notification.dart';
import 'package:tcc/new/Eisen/lista_controller.dart';
import 'package:tcc/new/controller/esienhower_controller.dart';
import 'package:tcc/new/controller/retainer.dart';

class ListaToDo extends StatefulWidget {
  List<String> EisenToDo;

  ListaToDo({required this.EisenToDo});

  @override
  State<ListaToDo> createState() => _ListaToDoState();
}

class _ListaToDoState extends State<ListaToDo> {
  late Future<void> _dataLoadingFuture;

  @override
  void initState() {
    super.initState();
    _dataLoadingFuture = _loadData();
  }

  Future<void> _loadData() async {
    var list = await GetStateActivitiesList('toDo');
    if (list != null && list.isNotEmpty && list[0].isNotEmpty) {
      widget.EisenToDo = EisenhowerMatrix.getMatrizEisenhower;
      Recipient.tarefas = list;
      print('Recipiente: ${Recipient.tarefas}');
      var statesList = await GetStateList('states');
      Recipient.theStates = statesList;
    } else {
      Recipient.tarefas = [];
      Recipient.theStates = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _dataLoadingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        } else {
          // Dados carregados, agora renderize a lista
          List<int> iconStates = [];
          int i = 0;
          if (Recipient.theStates.isNotEmpty) {
            widget.EisenToDo.forEach((element) {
              if ((Recipient.theStates[i] == 0 && element == Recipient.tarefas[i]) ||
                  (Recipient.theStates[i] == 1 && element == Recipient.tarefas[i])) {
                iconStates.add(Recipient.theStates[i]);
                i++;
                if (i >= Recipient.theStates.length) {
                  i = 0;
                }
              } else {
                iconStates.add(0);
              }
            });
          } else {
            iconStates = List<int>.filled(widget.EisenToDo.length, 0, growable: true);       
          }
          CriarNotificacaoLembrarTarefa(iconStates, widget.EisenToDo);
          return PopScope(
            canPop: true,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: (widget.EisenToDo.isNotEmpty && widget.EisenToDo[0].isNotEmpty)
                  ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                      child: Column(
                          children: widget.EisenToDo.asMap().entries.map((entry) {
                            int ping = 0;
                            int indiceCaixa = entry.key;
                            String element = entry.value;
                            return SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  iconStates[indiceCaixa] = iconStates[indiceCaixa] == 0 ? 1 : 0;
                                                  Recipient.saveStates(iconStates, widget.EisenToDo);
                                                  SaveStateList(Recipient.theStates, 'states');
                                                  SaveStateActivitiesList(Recipient.tarefas, 'toDo');
                                                  CriarNotificacaoLembrarTarefa(Recipient.theStates, Recipient.tarefas);
                                                });
                                              },
                                              child: BoxIconController(indiceIcone: iconStates[indiceCaixa])),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (iconStates[indiceCaixa] == 0)
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 10, left: 5, right: 10),
                                                    child: Text(
                                                      element,
                                                      textAlign: TextAlign.start,
                                                      style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (iconStates[indiceCaixa] == 1)
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 10, left: 5, right: 10),
                                                    child: Text(
                                                      element,
                                                      textAlign: TextAlign.start,
                                                      style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          color: Color.fromRGBO(88, 88, 88, 0.498),
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              EisenhowerMatrix.findAndDelete(element);
                                              ListaToDoControl.updateIt();
                                              iconStates.removeAt(indiceCaixa);
                                              for (var e in Recipient.tarefas) {
                                                if (e == element) {
                                                  ping = 1;
                                                }
                                              }
                                              if (ping == 1) {
                                                Recipient.removeState(iconStates, indiceCaixa);
                                                SaveStateList(Recipient.theStates, 'states');
                                                SaveStateActivitiesList(Recipient.tarefas, 'toDo');
                                                CriarNotificacaoLembrarTarefa(Recipient.theStates, Recipient.tarefas);
                                              }
                                            },
                                            child: Icon(
                                              Icons.highlight_remove_rounded,
                                              fill: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ),
                  )
                  : Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        'Adicione Tarefas!',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          );
        }
      },
    );
  }
}

class BoxIconController extends StatelessWidget {
  final int indiceIcone;
  IconData icone = Icons.check_box_outline_blank_sharp;

  BoxIconController({required this.indiceIcone}) {
    icone = indiceIcone == 0 ? Icons.check_box_outline_blank_rounded : Icons.indeterminate_check_box_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      icone,
      size: 30,
      fill: 1,
    );
  }
}

class Recipient {
  static List<int> theStates = [];
  static List<String> tarefas = [];

  static void saveStates(List<int> toSave, List<String> tarefa) {
    tarefas.clear();
    theStates = toSave;
    tarefas.addAll(tarefa);
  }

  static void removeState(List<int> trashBag, int key) {
    theStates = trashBag;
    tarefas.removeAt(key);
  }
}
