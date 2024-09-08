// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tcc/new/Ajuda/Contatos.dart';
import 'package:tcc/new/Ajuda/Instru%C3%A7%C3%B5es.dart';
import 'package:tcc/new/Ajuda/Termo.dart';
import 'package:tcc/new/Components/defaultPage.dart';
import 'package:tcc/new/Components/myIconBox.dart';


class AjudaView extends StatelessWidget {
  const AjudaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  DefaultPage(texto: 'Ajuda'),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/4.4),
                      Center(
                        child: InkWell(
                          child: MyIconBox(
                            boxColor: Colors.white,
                            boxIcon: 'Assets/Imgs/icons/Icon_contatos.png',
                            boxLabel: 'Contatos',
                          ),
                        onTap: ()
                        {
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContatosView()));
                        },
                        ),
                      ),
                      Center(
                        child: InkWell(
                          child: MyIconBox(
                            boxColor: Colors.white,
                            boxIcon: 'Assets/Imgs/icons/Icon_termo.png',
                            boxLabel: 'Termos',
                          ),
                        onTap: ()
                        {
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermoView()));
                        },
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InstrucoesView()));
                          },
                          child: MyIconBox(
                            boxColor: Colors.white,
                            boxIcon: 'Assets/Imgs/icons/Icon_eisenhoer.png',
                            boxLabel: 'Instruções',
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            )
    );
  }
}

//Implementar o view do configuracoes
//Fazer as view/funcionalidades da tela ajuda 


