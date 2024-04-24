import 'package:app_produtividade/controllers/excel_services.dart';
import 'package:flutter/material.dart';

class CadastroSimples extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final ExcelServices _excelServices = ExcelServices(
    'C:/Users/Usuario/Downloads/teste.xlsx',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Export Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Preencha os campos:'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _controller1,
                          decoration: InputDecoration(labelText: 'Campo 1'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controller2,
                          decoration: InputDecoration(labelText: 'Campo 2'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controller3,
                          decoration: InputDecoration(labelText: 'Campo 3'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controller4,
                          decoration: InputDecoration(labelText: 'Campo 4'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _controller5,
                          decoration: InputDecoration(labelText: 'Campo 5'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _excelServices.insertData('A1', _controller1.text);
                          _excelServices.insertData('A2', _controller2.text);
                          _excelServices.insertData('A3', _controller3.text);
                          _excelServices.insertData('A4', _controller4.text);
                          _excelServices.insertData('A5', _controller5.text);
                          _excelServices.saveExcel();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Salvar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Abrir Diálogo'),
        ),
      ),
    );
  }
}
