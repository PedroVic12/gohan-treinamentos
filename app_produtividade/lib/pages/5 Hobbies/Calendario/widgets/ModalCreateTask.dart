import 'package:app_produtividade/api/Gohan_api.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarioPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/CampoTextoCard.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/Custom/CustomText.dart';
import '../CalendarioController.dart';

class ModalPegarEventosCalendario extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController eventNameController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final double altura;

  ModalPegarEventosCalendario({super.key, required this.altura});

  @override
  Widget build(BuildContext context) {
    CalendarioController calendario = Get.find<CalendarioController>();
    final alturaModal = altura * 0.7;

    return StatefulBuilder(builder: (_, modalSetState) {
      return Expanded(
        child: SizedBox(
          height: alturaModal,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                _buildTopIndicator(),
                const CustomText(text: 'Criar uma nova tarefa'),
                _buildEventForm(calendario),
                const SizedBox(height: 8),
                _buildCategorySection(calendario),
                const SizedBox(height: 8),
                _buildDateTimeSection(modalSetState, calendario),
                const CustomText(text: 'Prioridades'),
                DropDownCategoria(),
                BotaoSalvarEventos(context, calendario),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTopIndicator() {
    return Container(
      width: 60,
      height: 5,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildEventForm(CalendarioController calendario) {
    return Form(
      key: _formKey,
      child: CampoDeTextoCard(
        child: TextFormField(
          onChanged: calendario.atualizarNomeDoEvento,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor, insira o nome do evento.';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: 'Nome do Evento',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(CalendarioController calendario) {
    return Column(
      children: [
        Card(child: const CustomText(text: 'Categorias')),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotaoPrioridade(
                label: 'Trabalho',
                color: Colors.green,
                selected: calendario.prioridadeSelecionada.value == 'Trabalho',
                onPressed: () => calendario.atualizarPrioridade('Trabalho'),
              ),
              BotaoPrioridade(
                label: 'Faculdade',
                color: Colors.purpleAccent,
                selected: calendario.prioridadeSelecionada.value == 'Faculdade',
                onPressed: () => calendario.atualizarPrioridade('Faculdade'),
              ),
              BotaoPrioridade(
                label: 'Projetos',
                color: Colors.red,
                selected: calendario.prioridadeSelecionada.value == 'Projetos',
                onPressed: () => calendario.atualizarPrioridade('Projetos'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection(void Function(void Function()) modalSetState,
      CalendarioController calendario) {
    return Column(
      children: [
        const CustomText(text: 'Data e Hora'),
        Divider(),
        DateTimePickerWidget(
          onDateSelected: (date) {
            modalSetState(() {
              selectedDate = date;
              calendario.atualizarDataSelecionada(date);
            });
          },
          onTimeSelected: (time) {
            modalSetState(() {
              selectedTime = time;
              calendario.atualizarHoraSelecionada(time);
            });
          },
        ),
      ],
    );
  }

  Widget BotaoSalvarEventos(
      BuildContext context, CalendarioController calendario) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _onSavePressed(context, calendario),
        child: const Text('Salvar Evento Canônico'),
      ),
    );
  }

  void _onSavePressed(BuildContext context, CalendarioController calendario) {
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

// Enviando os dados para o servidor
      final GohanFastApi api = GohanFastApi();
      api.postData({
        "nomeDoEvento": calendario.nomeDoEvento.value,
        "prioridade": calendario.prioridadeSelecionada.value,
        "data": calendario.dataSelecionada.value.toString(),
        "hora": calendario.horaSelecionada.value.toString(),
        "categoria": calendario.categoriaSelecionada.value,
      });

      Get.to(() => CalendarioPage());
    } else if (selectedDate == null) {
      _showErrorSnackbar('Erro!', 'Por favor, selecione uma data.');
    } else if (selectedTime == null) {
      _showErrorSnackbar('Erro!', 'Por favor, selecione uma hora.');
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 5),
    );
  }
}
