import 'package:app_produtividade/pages/PlanosGENAI/Planos%20de%20treino/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'controller/genai_plan_treino_controlle.dart';

//! https://ai.google.dev/gemini-api/docs/function-calling/dart?authuser=1

class PlanoDeTreinoWidget extends StatefulWidget {
  const PlanoDeTreinoWidget({super.key});

  @override
  State<PlanoDeTreinoWidget> createState() => _PlanoDeTreinoWidgetState();
}

class _PlanoDeTreinoWidgetState extends State<PlanoDeTreinoWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  final controller = GeminiController();
  final _planner = IAplanner();
  String respostaGemini = "";

  String _results = '';
  String _selectedObjective = 'Manter Peso';

  @override
  void initState() {
    super.initState();
    // _planner
    //     .gerarPrompt()
    //     .then((prompt) => setState(() => _planner.user_data = prompt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("IA MEAL PLANNER"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedObjective,
                items: _planner.objetivo.map((String objective) {
                  return DropdownMenuItem<String>(
                    value: objective,
                    child: Text(objective),
                  );
                }).toList(),
                onChanged: (objective) =>
                    setState(() => _selectedObjective = objective!),
              ),
              const SizedBox(height: 16.0),
              InputField(
                  labelText: 'Genero (Opcional)',
                  controller: _planner.generoInput),
              const SizedBox(height: 16.0),
              InputField(
                  labelText: 'Idade',
                  validator: (value) {},
                  controller: _planner.idadeInput),
              const SizedBox(height: 16.0),
              InputField(
                labelText: 'Altura (cm)',
                controller: _planner.alturaInput,
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Digite uma altura válida.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              InputField(
                controller: _planner.pesoInput,
                labelText: 'Peso (kg)',
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Digite um peso válido.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implementar API call e processamento de dados
                    _results = _planner.generatPrompt();
                    setState(() {
                      print(_results);
                      respostaGemini = _results;
                    });
                  }
                },
                child: const Text('Gerar Plano de Treino'),
              ),

              // animated text c3po
              // 8:14 front end com cards em colunas dos dados do usuario
              // resultado esperado é um formato json para cada dia e os dados iniciais
              if (_results.isNotEmpty) ...[
                const SizedBox(height: 16.0),

                // Plano gerado organizado e bem informativo para o usuario
                Text('Plano Gerado:',
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 8.0),
                Text(_results),
              ],

              //showRespostaAssistente(_results),
              Card(child: Text(respostaGemini)),

              InputField(
                  labelText: 'Pergunte ao Goku modo Super Sayajin',
                  controller: _planner.genaiInputUser),

              // todo gerar prompt simples com esses dados
            ],
          ),
        ),
      ),
    );
  }

  Widget showRespostaAssistente(results) {
    return Column(
      children: [
        Visibility(
          visible: controller.isLoading,
          child: const CircularProgressIndicator(),
        ),
        Visibility(
          visible: !controller.isLoading && results != null,
          child: Align(
            alignment: Alignment.topLeft,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: AnimatedTextKit(
                    key: ValueKey(results),
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      //TyperMarkdownAnimatedText(results!,
                      //  speed: Duration(milliseconds: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: results!));
            },
            child: Text("Copiar Resposta")),
      ],
    );
  }
}
