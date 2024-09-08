// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:tcc/new/Components/defaultPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermoView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  DefaultPage(texto: 'TERMO DE CONSENTIMENTO LIVRE\nE ESCLARECIDO'),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/5),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 25, bottom:10),
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(15, 29, 74, 1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                'O (A) Senhor (a) está sendo convidado (a) a participar de uma pesquisa. Por favor, leia este documento com bastante atenção antes de assiná-lo. Caso haja alguma palavra ou frase que o (a) senhor (a) não consiga entender, converse com o pesquisador responsável pelo estudo ou com um membro da equipe desta pesquisa para esclarecê-los. '
                                'O objetivo desta pesquisa é avaliar três métodos diferentes de manejamento de tempo no primeiro ano do curso técnico de eletrônica da Fundação Escola Técnica Liberato Salzano Vieira da Cunha, verificando qual mostrou maior aceitação neste público. '
                                'Se o(a) Sr.(a) aceitar participar da pesquisa, os procedimentos envolvidos em sua participação são os seguintes: experimentar os três diferentes métodos de foco, o método pomodoro, a meditação com ondas binaurais e a matriz de eisenhower, através de um aplicativo desenvolvido pela equipe de pesquisa. O experimento durará duas semanas e, após, será preenchido um formulário de satisfação. '
                                'Toda pesquisa com seres humanos envolve algum tipo de risco. No nosso estudo, os possíveis riscos ou desconfortos decorrentes da participação na pesquisa são provenientes do método de meditação por ondas binaurais, que pode gerar desconforto naqueles com audição sensível. '
                                'Contudo, esta pesquisa também pode trazer benefícios. Os possíveis benefícios resultantes da participação na pesquisa são destinar melhor o tempo livre, manejando eficientemente tarefas através de um acompanhamento contínuo da organização e do foco. '
                                'Sua participação na pesquisa é totalmente voluntária, ou seja, não é obrigatória. Caso o(a) Sr.(a) decida não participar, ou ainda, desistir de participar e retirar seu consentimento durante a pesquisa, não haverá nenhum prejuízo à sua avaliação curricular. '
                                'Não está previsto nenhum tipo de pagamento pela sua participação na pesquisa e o(a) Sr.(a) não terá nenhum custo com respeito aos procedimentos envolvidos. '
                                'Solicitamos também sua autorização para apresentar os resultados deste estudo em eventos da área de pesquisa científica. Por ocasião da publicação dos resultados, seu nome será mantido em sigilo absoluto, bem como em todas as fases da pesquisa. '
                                'É assegurada a assistência durante toda pesquisa, bem como é garantido ao Sr.(a), o livre acesso a todas as informações e esclarecimentos adicionais sobre o estudo e suas consequências, enfim, tudo o que o(a) Sr.(a) queira saber antes, durante e depois da sua participação. '
                                'Caso o(a) Sr.(a) tenha dúvidas, poderá entrar em contato com o pesquisador responsável Gustavo Henrique Becker, pelo telefone +55 (51) 9 9397-5748 e/ou pelo e-mail 21000258@liberato.com.br, com o pesquisador Lucca Brusque Guimarães, pelo telefone +55 (51) 9 9374-4220 e/ou pelo e-mail 21000265@liberato.com.br, com a orientadora Deise Margô Müler pelo email deise.margo@liberato.com.br ou com o Comitê de Ética e Segurança na Pesquisa (Cesp - LIBERATO SALZANO VIEIRA DA CUNHA. Endereço: R. Inconfidentes, 365, RS, Sala 1 (biblioteca) - Cep: 93340-140, E-mail: cesp@liberato.com.br.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                ),),
                              ),
                            ),
                          ) 
                          ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                              width: 240,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(15, 29, 74, 1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                          child: Center(child: Text('Entendi', 
                          style: GoogleFonts.montserrat
                          (
                            textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )
                          ))),
                          ),
                        ),
                      ),
                      )
                  ])
                ]
              )
      )
    );
  }
}
