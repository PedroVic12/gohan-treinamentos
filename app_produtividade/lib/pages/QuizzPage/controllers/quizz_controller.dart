class QuizzController {
  int score = 0;
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Qual é a cor do céu?",
    "Qual é a cor do sol?",
    "Qual é a cor da lua?",
  ];
  List<String> options = [
    "Azul, Verde, Amarelo",
    "Azul, Verde, Amarelo",
    "Azul, Verde, Amarelo",
  ];
  List<String> correctAnswers = [
    "Azul",
    "Amarelo",
    "Amarelo",
  ];

  void reset() {
    score = 0;
    currentQuestionIndex = 0;
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
  }

  void checkAnswer(String userAnswer) {
    if (userAnswer == correctAnswers[currentQuestionIndex]) {
      score += 1;
    }
    nextQuestion();
  }
}
