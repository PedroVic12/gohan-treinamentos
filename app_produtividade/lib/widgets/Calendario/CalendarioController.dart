
 import 'package:app_produtividade/widgets/Calendario/Eventos.dart';

import 'RepositoryCalendario.dart';

List<String> getServicosDoDiaSelecionado(DateTime diaSelecionado) {
    List<EventosCalendario> eventos = [];

    // Percorre o mapa de eventos e adiciona na lista somente os eventos do dia selecionado
    MEU_REPOSITORY.forEach((key, evento) {
      if (evento.data_hora_evento.year == diaSelecionado.year &&
          evento.data_hora_evento.month == diaSelecionado.month &&
          evento.data_hora_evento.day == diaSelecionado.day) {
        eventos.add(evento);
      }
    });

    // Retorna a lista de serviços dos eventos do dia selecionado
    return eventos.map((evento) => evento.servicos).expand((i) => i).toList();
  }



  // Retorna os eventos do dia selecionado
 // List<EventosCalendario> get selectedEvents {

   // if (_events.value[diaSelecionado] != null) {
     // return _events.value[diaSelecionado]!;
    //} else {
      // Retornar uma lista com um evento padrão
      //return [EventosCalendario(nome_evento: "Nenhum evento disponível", data_hora_evento: DateTime.now(), servicos: ['Sem serviço'])];
    //}
  //}

