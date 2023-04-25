import 'dart:async';
import 'package:app_produtividade/pages/Pomodoro%20Timer/models/TimerModel.dart';

class CountDownTimer {
  //Atributos
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fullTime;

  //Constantes
  int work = 50;

  // Métodos
  void startWork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  String calculaTempo(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();

    int seconds = t.inSeconds - (t.inSeconds * 60);
    String secondsString =
        (seconds < 10) ? '0' + seconds.toString() : seconds.toString();

    String tempoFormatado = minutes + ':' + secondsString;

    return tempoFormatado;
  }

  //? O metodo recebe o tempo que o usuario quer que o timer funcione

  //? O asteristico depois do async indica que a Stream ainda vai ser retornada (async)
  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;

      if (this._isActive) {
        this._time = this._time - Duration(seconds: 1);
        this._radius = this._radius - (1 / this._fullTime.inSeconds);

        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }

      time = calculaTempo(this._time);
      return TimerModel(time, this._radius);
    });
  }
}

void main(List<String> args) {
  CountDownTimer timer = CountDownTimer();
  timer.stream().listen((event) {
    print(event.time);
  });
}
