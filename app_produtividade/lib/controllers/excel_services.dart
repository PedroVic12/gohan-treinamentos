import 'dart:io';
import 'package:excel/excel.dart';

class ExcelServices {
  late String _filePath;
  late Excel _excel;

  ExcelServices(String filePath) {
    _filePath = filePath;
    _excel = Excel.createExcel();
  }

  void insertData(String cell, value) {

  }

  Future<void> saveExcel() async {
    final file = File(_filePath);
    final bytes = _excel.encode();
    // await file.writeAsBytes(bytes);
  }

  Future<void> exportExcel() async {
    final file = File(_filePath);
    final bytes = _excel.encode();
    //await file.writeAsBytes(bytes);
    // Adicione aqui a lógica para exportar o arquivo para download
  }
}
