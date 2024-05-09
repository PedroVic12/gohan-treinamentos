import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CsvDataTable extends StatefulWidget {
  final String filePath;

  const CsvDataTable({Key? key, required this.filePath}) : super(key: key);

  @override
  _CsvDataTableState createState() => _CsvDataTableState();
}

class _CsvDataTableState extends State<CsvDataTable> {
  List<List<dynamic>>? _data;
  int _diasRestantes = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Carrega dados do arquivo CSV
  Future<void> _loadData() async {
    final input = File(widget.filePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    setState(() {
      _data = fields;
      _calcularDiasRestantes(); // Calcula dias restantes na inicialização
    });
  }

  // Calcula dias restantes para a data na célula (1, 2)
  void _calcularDiasRestantes() {
    if (_data != null && _data!.length > 1 && _data![1].length > 1) {
      try {
        final dateString = _data![1][1];
        final date = DateFormat("dd/MM/yyyy").parse(dateString);
        final today = DateTime.now();
        final difference = date.difference(today).inDays;
        setState(() {
          _diasRestantes = difference;
        });
      } catch (e) {
        print("Erro ao analisar data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabela CSV"),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                DataTable(
                  columns: _data![0]
                      .map((e) => DataColumn(label: Text(e.toString())))
                      .toList(),
                  rows: _data!
                      .sublist(1)
                      .map((row) => DataRow(
                          cells: row
                              .map((cell) => DataCell(Text(cell.toString()),
                                  onTap: () {
                                    // Ao clicar em uma célula, atualiza a data
                                    // e recalcula os dias restantes
                                    setState(() {
                                      _data![1][1] = cell.toString(); 
                                      _calcularDiasRestantes();
                                    });
                                  }))
                              .toList()))
                      .toList(),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Dias restantes: $_diasRestantes",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}