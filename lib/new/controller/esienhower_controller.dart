// ignore_for_file: prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls

import 'package:tcc/new/Components/listaToDo_view.dart';
import 'package:tcc/new/controller/retainer.dart';

class EisenhowerMatrix
{

  static List<String> uI = [];
  static List<String> uN = [];
  static List<String> nI = [];
  static List<String> nN = [];

  static List<String> matrizEisenhower = [];



  static void cleanMatrizEisenhower() async
  {
    matrizEisenhower.clear();
    uI.clear();
    SaveEisenLists(uI, 'uI');
    uN.clear();
    SaveEisenLists(uN, 'uN');
    nI.clear();
    SaveEisenLists(nI, 'nI');
    nN.clear();
    SaveEisenLists(nN, 'nN');
    Recipient.theStates.clear();
    Recipient.tarefas.clear();
    SaveStateList(Recipient.theStates, 'states');
    SaveStateActivitiesList(Recipient.tarefas, 'toDo');
  }

  static void findAndDelete(trashString)
  {

    int finished = 0;
    String el = '';
    List<String> comando =  [];
    int ocorrencias = 0;

    do
    {
      uI.forEach((element)
      {
        if(element == trashString)
        {
          ocorrencias++;
          el = element;
          comando.add('A');
        }
      });
      nI.forEach((element)
      {
        if(element == trashString)
        {
          ocorrencias++;
          el = element;
          comando.add('B');
        }
      });
      uN.forEach((element)
      {
        if(element == trashString)
        {
          ocorrencias++;
          el = element;
          comando.add('C');
        }
      });
      nN.forEach((element)
      {
        if(element == trashString)
        {
          ocorrencias++;
          el = element;
          comando.add('D');
        }
      });
      finished = 1;
    } while(finished == 0);

    for(int i = 0; i<ocorrencias; i++)
    {  
      if(comando[i] == 'A')
      {
        uI.removeAt(uI.indexOf(el));
        SaveEisenLists(uI, 'uI');
      }else if(comando[i] == 'B')
      {
        nI.removeAt(nI.indexOf(el));
        SaveEisenLists(nI, 'nI');
      }else if(comando[i] == 'C')
      {
        uN.removeAt(uN.indexOf(el));
        SaveEisenLists(uN, 'uN');
      }else if(comando[i] == 'D')
      {
        nN.removeAt(nN.indexOf(el));
        SaveEisenLists(nN, 'nN');
      }
    }
    

    matrizEisenhower = [...uI,...nI, ...uN, ...nN];
    matrizEisenhower = matrizEisenhower.toSet().toList();
    comando.clear();
  }


   static List<String> get getMatrizEisenhower
  {
    return matrizEisenhower;
  }

  static Future<void> setMatrizEisenhower() async {
    try {
      List<String>? listUI = await getEisenLists('uI');
      List<String> tempListUI = listUI ?? [];
      if (tempListUI.isNotEmpty && tempListUI[0].isNotEmpty) {
        uI = tempListUI;
      }

      List<String>? listUN = await getEisenLists('uN');
      List<String> tempListUN = listUN ?? [];
      if (tempListUN.isNotEmpty && tempListUN[0].isNotEmpty) {
        uN = tempListUN;
      }

      List<String>? listNI = await getEisenLists('nI');
      List<String> tempListNI = listNI ?? [];
      if (tempListNI.isNotEmpty && tempListNI[0].isNotEmpty) {
        nI = tempListNI;
      }

      List<String>? listNN = await getEisenLists('nN');
      List<String> tempListNN = listNN ?? [];
      if (tempListNN.isNotEmpty && tempListNN[0].isNotEmpty) {
        nN = tempListNN;
      }

      // Atualizando a matriz após carregar todos os dados
      matrizEisenhower = [...uI, ...nI, ...uN, ...nN];
      matrizEisenhower = matrizEisenhower.toSet().toList();
    } catch (e) {
      print('Erro ao carregar matrizes: $e');
    }
  }


  static void gestaoMatriz(List<dynamic> lista, var importancia, var urgencia){
    matrizEisenhower.clear();

    if(importancia == 0 && urgencia == 0)
    {
      uI.addAll(lista.map((item)=> item.toString()).toList());
      SaveEisenLists(uI, 'uI');
    }else if(importancia == 1 && urgencia == 0)
    {
      uN.addAll(lista.map((item)=> item.toString()).toList());
      SaveEisenLists(uN, 'uN');
    }else if(importancia == 0 && urgencia == 1)
    {
      nI.addAll(lista.map((item)=> item.toString()).toList());
      SaveEisenLists(nI, 'nI');
    }else if(importancia == 1 && urgencia == 1)
    {
      nN.addAll(lista.map((item)=> item.toString()).toList());
      SaveEisenLists(nN, 'nN');
    }

    matrizEisenhower = [...uI, ...nI, ...uN, ...nN];
    matrizEisenhower = matrizEisenhower.toSet().toList();

    lista.clear();
  }

}