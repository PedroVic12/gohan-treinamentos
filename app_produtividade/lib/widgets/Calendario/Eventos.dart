class EventosCalendario {
  String nome_evento;
  DateTime data_hora_evento;
  List<String> servicos;

  EventosCalendario(
      {required this.nome_evento,
      required this.data_hora_evento,
      required this.servicos});
}
