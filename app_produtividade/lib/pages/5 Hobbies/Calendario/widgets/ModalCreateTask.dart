import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarioPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/CampoTextoCard.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/Custom/CustomText.dart';
import '../CalendarioController.dart';

class CreateTaskFields extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController eventNameController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final double altura;

  CreateTaskFields({super.key, required this.altura});

  @override
  Widget build(BuildContext context) {
    CalendarioController calendario = Get.find<CalendarioController>();

    return StatefulBuilder(builder: (_, modalSetState) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Esta linha permite ajustar o espaço quando o teclado é exibido.
          ),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const CustomText(text: 'Criar uma nova tarefa'),
              Form(
                key: _formKey,
                child: CampoDeTextoCard(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          calendario.atualizarNomeDoEvento(value);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, insira o nome do evento.';
                          }
                          return null; // tudo certo com o valor
                        },
                        decoration: const InputDecoration(
                            hintText: 'Nome do Evento',
                            border: InputBorder.none),
                      ),
                      //TextFormField(
                      //onChanged: (value) {
                      //print('Tipo: $value');
                      //calendario.atualizarTipoDoEvento(value);
                      //},
                      //validator: (value) {},
                      //decoration: const InputDecoration(
                      //  hintText: 'Tipo', border: InputBorder.none),
                      //),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(child: const CustomText(text: 'Categorias')),
              Container(
                  child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BotaoPrioridade(
                      label: 'Trabalho',
                      color: Colors.green,
                      selected:
                          calendario.prioridadeSelecionada.value == 'Trabalho',
                      onPressed: () {
                        print(calendario.prioridadeSelecionada.value);
                        calendario.atualizarPrioridade('Trabalho');
                      },
                    ),
                    BotaoPrioridade(
                      label: 'Faculdade',
                      color: Colors.purpleAccent,
                      selected:
                          calendario.prioridadeSelecionada.value == 'Faculdade',
                      onPressed: () {
                        print(calendario.prioridadeSelecionada.value);

                        calendario.atualizarPrioridade('Faculdade');
                      },
                    ),
                    BotaoPrioridade(
                      label: 'Projetos',
                      color: Colors.red,
                      selected:
                          calendario.prioridadeSelecionada.value == 'Projetos',
                      onPressed: () {
                        print(calendario.prioridadeSelecionada.value);

                        calendario.atualizarPrioridade('Projetos');
                      },
                    ),
                  ],
                ),
              )),
              const SizedBox(
                height: 8,
              ),
              const CustomText(text: 'Data e Hora'),
              Divider(),
              DateTimePickerWidget(
                onDateSelected: (date) {
                  modalSetState(() {
                    selectedDate = date;
                    calendario.atualizarDataSelecionada(date);
                    print('Data selecionada: $date');
                  });
                },
                onTimeSelected: (time) {
                  modalSetState(() {
                    selectedTime = time;
                    calendario.atualizarHoraSelecionada(time);
                    print('Hora selecionada: $time');
                  });
                },
              ),
              const CustomText(text: 'Prioridades'),
              DropDownCategoria(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedDate != null &&
                        selectedTime != null) {
                      calendario.imprimirDadosDoEvento();

                      final DateTime eventDate = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      calendario.adicionarEventoNaDataSelecionada(
                        titulo: calendario.nomeDoEvento.value,
                        categoria: calendario.categoriaSelecionada.value,
                        hora: calendario.horaSelecionada.value as TimeOfDay,
                        prioridade: calendario.prioridadeSelecionada.value,
                      );

                      Get.to(() => CalendarioPage());

                      //!Validação de dados
                    } else if (selectedDate == null) {
                      Get.snackbar(
                        'Erro!', // Título
                        'Por favor, selecione uma data.', // Mensagem
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: Duration(seconds: 5),
                      );
                    } else if (selectedTime == null) {
                      Get.snackbar(
                        'Erro!', // Título
                        'Por favor, selecione uma hora.', // Mensagem
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        duration: Duration(seconds: 5),
                      );
                    }
                  },
                  child: const Text('Salvar Evento Canônico'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
