import 'package:app_produtividade/widgets/Calendario/Eventos.dart';

final MEU_REPOSITORY = {
  '1': EventosCalendario(
    nome_evento: 'Entregar Projeto Flutter',

    //ano | mes | dia | hora | minutos
    data_hora_evento: DateTime(2023, 5, 4, 17, 0),
    servicos: [
      '- Arrumar Calendário com funcionalidades com botoes com horarios',
      '- Api com Google Sheets + CRUD',
      '- May the 4th be with you'
    ],
  ),

  '2': EventosCalendario(
    nome_evento: 'Estudar Machine Learning',
    data_hora_evento: DateTime(2023, 5, 5, 15, 0),
    servicos: ['-> Revisar conceitos', '-< Fazer exercícios'],
  ),
  '3': EventosCalendario(
    nome_evento: 'Entregar Estudos Faculdade ',
    data_hora_evento: DateTime(2023, 5, 10, 12, 0),
    servicos: [
      '-> Lista de Exercicios Circuitos',
      '-< Prova Sinais e Sistemas',
      '- P1 Maquinas termicas'
    ],
  ),
  '4': EventosCalendario(
      nome_evento: 'Projeto Ciencia de dados',
      data_hora_evento: DateTime(2023, 5, 4, 12, 0),
      servicos: ['-Teste']),
  // Adicione mais eventos aqui
};

List<EventosCalendario> getEventsFromRepository() {
  return MEU_REPOSITORY.values.toList();
}
