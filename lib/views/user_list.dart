import 'dart:convert';

import 'package:GoBarber/API/api.dart';
import 'package:GoBarber/models/user.dart';
import 'package:GoBarber/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class UserList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Usuários'),
//         body: listaUsuarios(),
//       ),
//     );
//   }
// }

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  var user = new List<User>();

  _getCliente() {
    API.getClientes().then((response) {
      Iterable lista = json.decode(response.body);
      user = lista.map((model) => User.fromJson(model)).toList();
    });
  }

  _BuildListViewState() {
    _getCliente();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Usuários"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.USER_FROM);
          },
        ),
      ]),
      body: listaUsuarios(),
    );
  }

  listaUsuarios() {
    final avatar = CircleAvatar(child: Icon(Icons.person));
    return ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: avatar,
              title: Text(
                user[index].nome,
              ),
              subtitle: Text(user[index].cpf),
              trailing: Container(
                  width: 100,
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.USER_FROM,
                            arguments: User(
                                idCliente: user[index].idCliente,
                                nome: user[index].nome,
                                sexo: user[index].sexo));
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text('Excluir Usuário'),
                                      content: Text('Tem certeza?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Não'),
                                        ),
                                        FlatButton(
                                          child: Text('Sim'),
                                          onPressed: () async {
                                            // Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    AppRoutes.HOME);
                                            final baseUrl =
                                                "http://192.168.1.160/Api/";
                                            final url =
                                                Uri.parse(baseUrl + "cliente");
                                            final request =
                                                http.Request("DELETE", url);
                                            request.headers
                                                .addAll(<String, String>{
                                              "Content-type":
                                                  "application/json",
                                              "Accept": "application/json"
                                            });
                                            request.body = jsonEncode({
                                              "IdCliente": user[index].idCliente
                                            });
                                            final response =
                                                await request.send();
                                            if (response.statusCode != 200)
                                              return Future.error(
                                                  "error: status code ${response.statusCode}");
                                            return await response.stream
                                                .bytesToString();
                                          },
                                        ),
                                      ]));
                        })
                  ])));
        });
  }
}
