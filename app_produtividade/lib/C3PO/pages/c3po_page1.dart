import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_produtividade/C3PO/c3po.dart';
import 'package:app_produtividade/core/animated_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../widgets/Custom/CustomText.dart';

class C3poChatbotSimples extends StatefulWidget {
  const C3poChatbotSimples({Key? key}) : super(key: key);

  @override
  State<C3poChatbotSimples> createState() => _C3poChatbotSimplesState();
}

class _C3poChatbotSimplesState extends State<C3poChatbotSimples> {
  final controller = C3PoAssistente();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: formularioSimples((text) async {
            setState(() {
              controller.question = text;
              controller.isLoading = true;
            });
            controller.txtController.clear();

            final response =
                await controller.gemini.text(controller.question).then((value) {
              print(value?.output);
              var resposta = value?.output;

              setState(() {
                controller.answer = resposta;
                controller.isLoading = false;
              });
            });
          }, false, controller.txtController, "Pergunte ao TDAH"),
        ),
        SizedBox(height: 20),
        Image.network(
            'https://moseisleychronicles.files.wordpress.com/2015/11/untitled-215.gif'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(controller.question),
          ),
        ),
        showRespostaAssistente(),
      ],
    );
  }

  Widget formularioSimples(Function(String)? onTap, bool obscureText,
      TextEditingController controlador, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        onSubmitted: onTap,
        obscureText: obscureText,
        autocorrect: true,
        controller: controlador,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  Widget showRespostaAssistente() {
    return Column(
      children: [
        Visibility(
          visible: controller.isLoading,
          child: const CircularProgressIndicator(),
        ),
        Visibility(
          visible: !controller.isLoading && controller.answer != null,
          child: Align(
            alignment: Alignment.topLeft,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: AnimatedTextKit(
                    key: ValueKey(controller.answer),
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperMarkdownAnimatedText(controller.answer!,
                          speed: Duration(milliseconds: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: controller.answer!));
            },
            child: Text("Copiar Resposta")),
        Visibility(
          visible: controller.question.isEmpty && !controller.isLoading,
          child: const Center(
            child: CustomText(
              text: 'Faça uma pergunta ao c3po seu assistente virtual TDAH!',
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
