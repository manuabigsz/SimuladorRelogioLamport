import 'dart:math';

class Processo {
  final int id;
  List<int> tempos;
  int incremento;

  Processo(
    this.id,
    this.tempos,
  ) : incremento = tempos[1] - tempos[0];

  void recebeMensagem(int novoTempo, int tempoDestino) {
    tempos[tempoDestino] = max(tempos[tempoDestino], novoTempo);
  }
}
