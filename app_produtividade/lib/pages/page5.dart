import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/Custom/CustomContainer.dart';
import 'package:app_produtividade/widgets/ScrollTela.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Page 5 - Lei da Atração, Magnetistmo, Deus, Chakras'),
      ),
      body: MyGestureDetector(
        child: SafeArea(
          child: Center(
            child: Column(
              children: const [
                SimpleCard(
                    titulo: 'Conexão com os Elementos',
                    card_color: Colors.green,
                    items: [
                      '- Mãe Terra : Me Sustente!',
                      '- Pai Céu (Grande Espirito): Me abençoe!',
                      '- Avô Sol: Me Ilumine!',
                      '- Avó Lua: Me acolha!',
                    ]),
                SimpleCard(
                    titulo: 'Estudos da Biblia',
                    card_color: Colors.white54,
                    items: [
                      'Os 10 mandamentos de Moises...',
                      'Os 10 mandamentos de acordo com a biblia...'
                    ]),
                SimpleCard(
                    titulo: 'OS 7 CHAKRAS',
                    card_color: Colors.blue,
                    items: [
                      '1) Chakra da Cabeça',
                      '2) Chakra do Terceiro olho',
                      '3) Chakra da Garganta',
                      '4) Chakra do Coração',
                      '5) Chakra do Umbigo',
                      '6) Chakra Genital(outro nome)',
                      '7) Chakra Raiz '
                    ]),
                SimpleCard(
                    titulo: '4 Passos para a Prosperidade',
                    card_color: Colors.yellow,
                    items: [
                      'Honestidade: Tudo é energia, isso tem que vir primeiro de voce, não seja corrupto',
                      'Mentalidade Prospera: Vá atras do seus sonhos, busque seus proprios caminhos, mesmo que seja desafiador',
                      'Organização vs Bagunça: Organização de verdade reflete o universo, sua mente, corpo e alma tem que estar sempre organizada, limpa e conectada',
                      'Alvo Claro: O universo precisa ver e entender para te ajudar e te impulsionar o seu sonho, entao voce tem que ter um objetivo claro!'
                    ]),
                SimpleCard(
                    titulo: 'Como Elevar a sua Vibração',
                    card_color: Colors.transparent,
                    items: ['1) ']),
                SimpleCard(
                    titulo: 'Como Fazer um Reiki',
                    card_color: Colors.transparent,
                    items: ['1) '])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
