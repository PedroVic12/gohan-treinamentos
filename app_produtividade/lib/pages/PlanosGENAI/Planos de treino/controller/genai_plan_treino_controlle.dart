//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';

class GeminiController {
  final gemini = Gemini.instance;
  bool isLoading = false;

  // Simulate API interaction (replace with actual API calls)

  Future<String> gerarPlanoGenai(String prompt_user) async {
    String c3poDefault = """
    use texto simples e puro sem formatação e asteriscos, nao use markdown!!

    Voce é meu personal trainer, treinado por Goku em modo Super Sajyajin, Treinou com o Batman e treinou com Bruce Lee. Voce é especialista em karate, calistenia e musculação. Seu objetivo é me trazer um plano de treino detalhado com dicas para melhorar meu condicionamento fisico conforme nos dados do usuario. Lembre-se: No Pain No Gain!!!
    Seu estilo de treino vai ser focado em calistenia com os Treinos PUSH, PULL, Legs, ABS e Moviemntos calistenicos
    responda minhas perguntas de forma simples e direta e va sempre direto ao ponto!

    """;

    final response =
        await gemini.streamGenerateContent(c3poDefault + prompt_user).first;
    String textoSemMarkdown =
        response.output!.replaceAll(RegExp(r'\*\*|\*|\\n|\\t'), ' ');
    print(response.output);
    return response.output!.toString();
  }
}

class IAplanner {
  final List<String> objetivo = ["Ganhar Peso", "Manter Peso", "Perder Peso"];
  String user_data = ''; // Initialize with empty string
  final generoInput = TextEditingController(text: 'Masculino');
  final idadeInput = TextEditingController(text: '26');
  final alturaInput = TextEditingController(text: '1.72');
  final pesoInput = TextEditingController(text: '70');
  final nameInput = TextEditingController(text: 'Pedro Victor Veras');
  final genaiInputUser = TextEditingController();

  final Map<String, dynamic> calisteniaSystem = {
    "min_num_repeticoes": {"normal": 100, "Sayajin": 150, "Monstro": 250},
    "tipo_treino": ["Push", "Pull", "Legs", "Abs + core"],
    "Objetivo": ["Hipertrofia", "Manter Peso", "Secar"],
    "tempo_min_descanso": "15 - 30 segundos",
    "volume de treino": "100 reps por dia e x por semana",
    "Exercicios por Treino": "minimo 7 exercicios por grupo muscular",
    "Exercicios Padrao": [
      "Push up (diamante, normal, arqueiro, explosiva, reloginho) ",
      "Pull up (3) ",
      "Agachamento (3)",
      "Dips",
      "Muscle Up",
    ],
    "treino_abs": "minimo 5 min com descanso de 15 segundos ou sem descanso",
  };
  final Map<String, dynamic> output_format = {
    "range": "Minimo e maximo ideal de peso para conseguir o objetivo",
    "target": "Peso a ser alcançado para ganho escolhido pelo objetivo",
    "difference":
        "Quanto de peso deve ser ganho ou perdido dependendo do objetivo",
    "IMC": "Calculo do IMC baseado no peso e altura",
    "meal_plan": "Plano de treino para 7 dias para 4 semanas de treino",
    "total_days": "Total de dias estimado para concluir todo plano de treino",
    "weight_per_week":
        "Quanto de Peso tem que ganhar ou perder por semana para conseguir alcançar o objetivo",
  };
  generatPrompt() async {
    final Map<String, dynamic> inputUserData = {
      "Nome": nameInput,
      "genero": generoInput,
      "Idade": idadeInput,
      "Altura": alturaInput,
      "Peso:": pesoInput,
    };

    String prompt = calisteniaSystem.toString() +
        "Dadas essas informaçoes de uma pessoa ${inputUserData} \n que busca melhorar seu condicinamento fisco com foco em ${calisteniaSystem["Objetivo"][0]}, me de um output da seguinte forma com apenas formato JSON, only json, nothing else." +
        output_format.toString();

    final responseJson = await GeminiController().gerarPlanoGenai(prompt);
    final responseMap = jsonDecode(responseJson);

    return responseMap;
  }
}
