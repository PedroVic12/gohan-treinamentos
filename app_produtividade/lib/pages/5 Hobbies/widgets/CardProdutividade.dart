import 'package:flutter/material.dart';

class CardProdutividade extends StatelessWidget {
  const CardProdutividade({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxHeight: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    'Dicas de uma I.A para aprender melhor e ser mais Produtivo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          ' Divida as tarefas maiores em tarefas menores e mais gerenciáveis. Priorize as tarefas com base em sua importância e prazos.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Defina metas realistas: Estabeleça metas realistas para cada dia, levando em consideração suas limitações e a quantidade de trabalho que pode ser concluída em um determinado período de tempo. Evite sobrecarregar-se com expectativas irreais.\n\nEstabeleça metas claras: Defina metas específicas para cada sessão de estudo, seja por tópico, capítulo ou quantidade de exercícios a serem concluídos. Isso ajudará a direcionar seu foco e acompanhar seu progresso.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Revise regularmente: Dedique tempo regularmente para revisar o material já estudado. A revisão espaçada, onde você revisita o conteúdo em intervalos regulares, ajuda a fortalecer a retenção e a memória a longo prazo.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Use técnicas de gestão de tempo e produtividade como Pomodoro'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Varie as técnicas de estudo: Além de resolver questões, experimente outras técnicas de aprendizado, como resumos, mapas mentais, gravação de áudio, elaboração de flashcards, discussões em grupo, entre outras. Variedade ajuda a manter o interesse e a reforçar a aprendizagem por meio de diferentes abordagens.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Participe ativamente das aulas: Esteja presente e engajado durante as aulas. Faça anotações, faça perguntas, participe de discussões e atividades práticas. Isso ajudará você a consolidar o que está sendo ensinado e a identificar lacunas em seu entendimento.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Pratique resolução de problemas: Para matérias mais práticas, como programação, resolva problemas e exercícios práticos regularmente. Quanto mais você praticar, melhor se tornará na aplicação dos conceitos e na resolução de desafios.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Ensine para aprender: Uma ótima maneira de consolidar o que você aprendeu é ensinando-o a outra pessoa. Isso pode ser feito explicando os conceitos em voz alta para si mesmo, gravando vídeos explicativos ou ajudando colegas de classe com dúvidas.'),
                    ),
                    const ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'Identifique e minimize as distrações ao seu redor. ')),
                    const ListTile(
                      leading: Icon(Icons.check),
                      title: Text(
                          'Priorize o autocuidado, incluindo uma boa alimentação, sono adequado e exercícios físicos regulares'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
