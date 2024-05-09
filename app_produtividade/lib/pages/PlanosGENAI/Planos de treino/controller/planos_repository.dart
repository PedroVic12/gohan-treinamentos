
class GenaiPlanoTreino {
  generatPrompt() {
    var name = "Pedro";
    String dados_entrada_user= """
    Meu nome é ${name}
  """;

    final Map<String, dynamic> output_format = {
      "range": "Range of ideal Weight Range",
      "target": "Target Weight",
      "difference": "Weight i need to loose or gain",
      "IMC": "Calculated IMC",
      "meal_plan": "Plano de treino para 7 dias",
      "total_days": "Estimated Days to Reach Target wieght",
      "weight_per_week": "Weight to loose or gain  per Week",
    };

    String prompt = 

        dados_entrada_user +
        "Dadas essas informaçoes de uma pessoa que busca melhor seu condicinamento fisco com foco em ${arrayObjetivo}, me de um output da seguinte forma com apenas formato JSON, only json, nothing else." +
        output_format;
  }


  

final Map<String, dynamic> calisteniaSystem= {
      "min_num_repeticoes": {"normal": 100, "Sayajin": 150, "Monstro": 250},
      "tipo_treino": ["Push", "Pull", "Legs", "Abs + core"],
       "Objetivo" : ["Hipertrofia","Manter Peso", "Secar"],
       "tempo_min_descanso": "15 - 30 segundos",
        "volume de treino": 100 reps por dia e x por semana,
        "Exercicios por Treino": "minimo 7 exercicios por grupo muscular",
        "Exercicios Padrao": ["Push up (diamante, normal, arqueiro, explosiva, reloginho) ", "Pull up (3) ", "Agachamento (3)", "Dips", "Muscle Up", ],
        "treino_abs": "minimo 5 min com descanso de 15 segundos ou sem descanso",
    };


}
