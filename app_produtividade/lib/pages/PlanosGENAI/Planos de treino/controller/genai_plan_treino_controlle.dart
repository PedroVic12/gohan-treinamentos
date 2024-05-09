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

  generatePromptGemini(String text) {}
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
    return "Me de a informação, siga o output no seguinte formato. \n Me o output em formato em json, somente em json \n $output_format";
  }
}
