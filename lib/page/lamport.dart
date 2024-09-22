import 'dart:math';
import 'package:flutter/material.dart';

import '../model/processo.dart';

class SimuladorLamport extends StatefulWidget {
  @override
  _SimuladorLamportState createState() => _SimuladorLamportState();
}

class _SimuladorLamportState extends State<SimuladorLamport> {
  List<Processo> processos = [];
  final TextEditingController processoController = TextEditingController();
  final TextEditingController origemController = TextEditingController();
  final TextEditingController tempoOrigemController = TextEditingController();
  final TextEditingController destinoController = TextEditingController();
  final TextEditingController tempoDestinoController = TextEditingController();
  Random random = Random();
  List<Color> processoCores = [];

  @override
  void initState() {
    super.initState();
    processoCores = List.generate(10, (index) => Colors.white);
  }

  void addProcessos(int count) {
    setState(() {
      processos = List.generate(
          count, (index) => Processo(index + 1, gerarTemposIncrementais()));
    });
  }

  List<int> gerarTemposIncrementais() {
    List<int> tempos = [];
    int incremento = random.nextInt(10) + 1;
    int tempoAtual = 0;

    for (int i = 0; i < 10; i++) {
      tempos.add(tempoAtual);
      tempoAtual += incremento;
    }
    return tempos;
  }

  void simularEvento(int processoOrigem, int tempoOrigem, int processoDestino,
      int tempoDestino) {
    if (processoOrigem <= 0 ||
        processoOrigem > processos.length ||
        processoDestino <= 0 ||
        processoDestino > processos.length) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('IDs de processo inválidos!')));
      return;
    }

    setState(() {
      int relogioOrigem = processos[processoOrigem - 1].tempos[tempoOrigem];

      if (processos[processoDestino - 1].tempos[tempoDestino] <
          relogioOrigem + 1) {
        processos[processoDestino - 1].tempos[tempoDestino] = relogioOrigem + 1;

        for (int i = tempoDestino + 1;
            i < processos[processoDestino - 1].tempos.length;
            i++) {
          processos[processoDestino - 1].tempos[i] =
              processos[processoDestino - 1].tempos[i - 1] +
                  processos[processoDestino - 1].incremento;
        }
      }

      processoCores[processoDestino - 1] = Colors.yellow;

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          processoCores[processoDestino - 1] = Colors.white;
        });
      });
    });
  }

  DataTable criarTabelaRelogios() {
    List<DataRow> rows = processos.map((processo) {
      int index = processo.id - 1;
      return DataRow(cells: [
        DataCell(Text('P${processo.id}')),
        ...processo.tempos.map((tempo) {
          return DataCell(
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: processoCores[index],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$tempo'),
              ),
            ),
          );
        }),
      ]);
    }).toList();

    return DataTable(
      columns: [
        const DataColumn(label: Text('P')),
        ...List.generate(10, (index) => DataColumn(label: Text('t$index'))),
      ],
      rows: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simulador Lamport',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Configuração de Processos'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: processoController,
                    decoration: const InputDecoration(
                        labelText: 'Número de Processos',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    int count = int.parse(processoController.text);
                    addProcessos(count);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1.5),
            _buildSectionTitle('Simulação de Evento'),
            _buildEventInputs(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int origem = int.parse(origemController.text);
                int tempoOrigem = int.parse(tempoOrigemController.text);
                int destino = int.parse(destinoController.text);
                int tempoDestino = int.parse(tempoDestinoController.text);
                simularEvento(origem, tempoOrigem, destino, tempoDestino);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const Text(
                'Simular Evento',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            processos.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(child: criarTabelaRelogios()))
                : const Center(
                    child:
                        Text('Adicione processos para visualizar a tabela.')),
          ],
        ),
      ),
    );
  }

  Widget _buildEventInputs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: origemController,
                decoration: const InputDecoration(
                    labelText: 'Origem', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: tempoOrigemController,
                decoration: const InputDecoration(
                    labelText: 'Tempo Origem', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: destinoController,
                decoration: const InputDecoration(
                    labelText: 'Destino', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: tempoDestinoController,
                decoration: const InputDecoration(
                    labelText: 'Tempo Destino', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple),
      ),
    );
  }
}
