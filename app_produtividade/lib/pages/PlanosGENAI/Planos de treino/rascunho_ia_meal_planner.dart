import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeminiController {
  // Simulate API interaction (replace with actual API calls)
  Future<String> connectApi() async {
    String userData = await rootBundle.loadString('assets/user_data.json');
    return userData;
  }

  // Simplified text generation (replace with actual model logic)
  String modeloGenerativoTxt(
      {required String userData, String objective = 'Manter Peso'}) {
    final Map<String, dynamic> plannerData = {
      "range": "Weight Range",
      "target": "Target Weight",
      "difference": "Weight to Adjust",
      "IMC": "Calculated BMI",
      "meal_plan": "Sample Meal Plan",
      "total_days": "Estimated Days to Reach Target",
      "weight_per_week": "Weight Adjustment per Week",
    };

    // Customize based on objective (replace with real calculations)
    plannerData["target"] = objective == "Ganhar Peso" ? 150 : 130;

    return jsonEncode(plannerData);
  }
}

class IAplanner {
  final List<String> objetivo = ["Ganhar Peso", "Manter Peso", "Perder Peso"];
  String user_data = ''; // Initialize with empty string

  String get output_format => """
  range: Range of ideal weight,
  target: Target weight,
  difference: Weight i need to loose or gain,
  IMC: Imc calculado,
  meal_plan: Meal plan for 7 days,
  total_days: Total days to reach target weight,
  weight_per_week: Weight to loose or gain per week
  """;

  Future<String> gerarPrompt() async {
    user_data = await GeminiController().connectApi();
    return "Me de a informação, siga o output no seguinte formato. \n Me o o output em formato em json, somente em json \n $output_format";
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const InputField({
    Key? key,
    required this.labelText,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}

class PlanoDeTreinoWidget extends StatefulWidget {
  const PlanoDeTreinoWidget({super.key});

  @override
  State<PlanoDeTreinoWidget> createState() => _PlanoDeTreinoWidgetState();
}

class _PlanoDeTreinoWidgetState extends State<PlanoDeTreinoWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _controller = GeminiController();
  final _planner = IAplanner();
  String _results = '';
  String _selectedObjective = 'Manter Peso';

  @override
  void initState() {
    super.initState();
    _planner
        .gerarPrompt()
        .then((prompt) => setState(() => _planner.user_data = prompt));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                InputField(labelText: 'Genero (Opcional)'),
                const SizedBox(height: 16.0),
                InputField(labelText: 'Idade', validator: (value) {}),
                const SizedBox(height: 16.0),
                InputField(
                  labelText: 'Altura (cm)',
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
                      _results = _controller.modeloGenerativoTxt(
                        userData: _planner.user_data,
                        objective: _selectedObjective,
                      );
                      setState(() {});
                    }
                  },
                  child: const Text('Gerar Plano de Treino'),
                ),
                if (_results.isNotEmpty) ...[
                  const SizedBox(height: 16.0),
                  Text('Plano Gerado:',
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 8.0),
                  Text(_results),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
