import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarregamentoWidget extends StatelessWidget {
  const CarregamentoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), // Indicador de carregamento
          SizedBox(height: 16), // Espaçamento
          Text('Carregando...'), // Texto "Carregando..."
        ],
      ),
    );
  }
}

class CarregamentoController extends GetxController {
  // Função para simular um carregamento
  Future<void> simulateLoading() async {
    await Future.delayed(const Duration( seconds: 2));
  }
}

class HomeScreen extends StatelessWidget {
  final controller = CarregamentoController();
  final isLoading = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Inicia o carregamento
            isLoading.value = true;

            // Simula um carregamento demorado
            await controller.simulateLoading();

            // Finaliza o carregamento
            isLoading.value = false;

            // Navega para a próxima tela
            Get.to(NextScreen());
          },
          child: Text('Iniciar Carregamento'),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  final homeScreen = Get.put(HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeScreen.isLoading.value) {
        // Se isLoading for true, mostra a tela de carregamento
        return CarregamentoWidget();
      } else {
        // Caso contrário, mostra a tela principal
        return Scaffold(
          appBar: AppBar(
            title: Text('Próxima Tela'),
          ),
          body: Center(
            child: Text('Tela Carregada!'),
          ),
        );
      }
    });
  }
}
