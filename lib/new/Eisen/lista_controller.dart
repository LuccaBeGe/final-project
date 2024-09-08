// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/new/controller/Exclude_fromList.dart';
import 'package:tcc/new/controller/esienhower_controller.dart';

int isTrash = 0;

class AdicionarTarefasView extends StatefulWidget {
  
  late int? importancia;
  late int? urgencia;
  late String? texto;
  
  AdicionarTarefasView({this.importancia, this. urgencia, this.texto});

  @override
  State<AdicionarTarefasView> createState() => _EisenhowerControllerState();
}

class _EisenhowerControllerState extends State<AdicionarTarefasView> {
  
  
  final TextEditingController inputController = TextEditingController();
  var auxList = [];

  var listaDeTarefas = [];
  String novaTarefa = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children:[ 
            Image.asset(
            'Assets/Imgs/background/backgournd.jpg', 
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(top:40, bottom: 20, right:10, left: 10),
              child: 
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('Adicionar tarefas ao campo',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('${widget.texto}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: inputController,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        decoration: InputDecoration(
                          hintText: 'Digite sua tarefa aqui!',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                           borderSide: BorderSide(
                            strokeAlign: 2,
                            color: Color.fromRGBO(15, 29, 74, 1),
                            width: 2,
                          ),
                          ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), 
                           borderSide: BorderSide(
                            strokeAlign: 2,
                            color: Color.fromRGBO(15, 29, 74, 1),
                            width: 2,
                          ),
                          ),
                        ),
                        onChanged: (value) {
                          novaTarefa = value;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: (){
                          setState(() {
                            if(isTrash == 1){
                             listaDeTarefas.clear();
                             listaDeTarefas.addAll(TrashCan.listValue);
                             isTrash = 0;
                            }
                            if(novaTarefa.trim().isEmpty){}
                            else{
                            listaDeTarefas.add(novaTarefa);
                            TrashCan.updateList(listaDeTarefas);
                            }
                            inputController.clear();
                            novaTarefa = ' ';
                          });
                        }, 
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(15, 29, 74, 1),
                            width: 2,
                          ),
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: 
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Adicionar tarefa à lista de tarefas',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            )
                          )
                        )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child:
                        ListView(lista: listaDeTarefas),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                        if(isTrash == 1){
                            listaDeTarefas.clear();
                            listaDeTarefas.addAll(TrashCan.listValue);
                            isTrash = 0;
                          }
                        auxList.addAll(listaDeTarefas);
                        EisenhowerMatrix.gestaoMatriz(auxList, widget.importancia, widget.urgencia);
                        EisenhowerMatrix.getMatrizEisenhower;
                        ListaToDoControl.updateIt();
                        Navigator.of(context).pop();
                        }, 
                        child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(15, 29, 74, 1),
                            width: 2,
                          ),
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: 
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Adicionar lista de tarefas à matriz',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            )
                          )
                        )
                        ),
                      ),
                    ]),
                  )],
                ),
              ),
          ),
        );
  }
}

class ListView extends StatelessWidget {

  late var lista = [];

  ListView({required this.lista}){
    if(isTrash == 1)
    {
    lista = TrashCan.listValue;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(                
          color: Color.fromRGBO(15, 29, 74, 1),
          width: 3,              
        ),
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 5, top: 6, bottom: 6),
          child: Column(
            children: [
                if(lista.isNotEmpty && lista[0].isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 30, right: 10, top: 10),
                  child: MyBulletList(lista: lista)),
                ]
              ),
        ),
        ),
    );
  }
}

class MyBulletList extends StatefulWidget {
  
  late var lista = [];

  MyBulletList({required this.lista});
  

  @override
  State<MyBulletList> createState() => _MyBulletListState();
}

class _MyBulletListState extends State<MyBulletList> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          widget.lista.asMap().entries.map((entry){
              int index = entry.key;
              String element = entry.value;
              return Row(
                key: ValueKey(index),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${index+1}.', 
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/30,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(element,
                      style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                          )
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/25),
                    ],),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/20,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        widget.lista = TrashCan.excluirElemento(element);
                        index = 0;
                        isTrash = 1;
                      });
                    },
                    child: Icon(Icons.remove_circle_rounded, size: MediaQuery.of(context).size.width/15,)),
                ],
              );
            }).toList(),
        ), 
      ),
    );
  }
}

class ListaToDoControl
{
  static Function()? updateList;

  static void updateIt()
  {
    if(updateList != null)
    {
      updateList!();
    }
  }

}