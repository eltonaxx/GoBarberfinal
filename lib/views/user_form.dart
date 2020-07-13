import 'package:GoBarber/API/api.dart';
import 'package:GoBarber/models/user.dart';
import 'package:GoBarber/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  final TextEditingController nomeController = new TextEditingController();
  final TextEditingController cpfController = new TextEditingController();
  final TextEditingController dataNascController = new TextEditingController();
  final TextEditingController sexoController = new TextEditingController();

  final Map<String, dynamic> _formDataum = {};
  void _loadFormaData(User user) {
    _formDataum['idCliente'] = user.idCliente.toString();
    _formDataum['nome'] = user.nome;
    _formDataum['cpf'] = user.cpf;
    _formDataum['sexo'] = user.sexo;
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    // _loadFormaData(
    //   user,
    // );
    print(user.nome);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                _form.currentState.save();
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                final String nome = nomeController.text;
                final String cpf = cpfController.text;
                final String sexo = sexoController.text;

                Map<String, String> headers = new Map<String, String>();
                headers["Content-type"] = "application/json";
                headers["Accept"] = "application/json";

                String str =
                    '{"nome" : "$nome","cpf" : "$cpf","sexo" : "$sexo"}';

                var url = baseUrl + "cliente/Salvar";
                var resp = await http.post(url, body: str, headers: headers);

                print(resp.body);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                // TextFormField(
                //   // initialValue: _formDataum['idCliente'],
                //   controller: nomeController,
                //   decoration: InputDecoration(labelText: "idCliente"),
                //   // ignore: non_constant_identifier_names
                //   onSaved: (Value) => _formData['idCliente'] = Value,
                // ),
                TextFormField(
                  initialValue: _formDataum['nome'],
                  controller: nomeController,
                  decoration: InputDecoration(labelText: "Nome"),
                  // ignore: non_constant_identifier_names
                  onSaved: (Value) => _formData['nome'] = Value,
                ),
                TextFormField(
                  initialValue: _formDataum['cpf'],
                  controller: cpfController,
                  decoration: InputDecoration(labelText: "CPF"),
                  // ignore: non_constant_identifier_names
                  onSaved: (Value) => _formData['cpf'] = Value,
                ),
                TextFormField(
                  initialValue: _formDataum['sexo'],
                  controller: sexoController,
                  decoration: InputDecoration(labelText: "Sexo"),
                  // ignore: non_constant_identifier_names
                  onSaved: (Value) => _formData['sexo'] = Value,
                ),
                Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              ],
            )),
      ),
    );
  }
}
