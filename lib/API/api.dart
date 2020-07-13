import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.1.160/Api/";

class API {
  static Future getClientes() async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"] = "application/json";
    headers["Accept"] = "application/json";

    var url = baseUrl + "cliente/Usuario";
    return await http.get(url, headers: headers);
  }
}

class APIPost {
  static Future postClientes() async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"] = "application/json";
    headers["Accept"] = "application/json";

    String str = '{"Nome" : "pelo app","Cpf" : "123456789","Sexo" : "F"}';

    var url = baseUrl + "cliente/Salvar";
    return await http.post(url, body: str, headers: headers);
  }
}

class APIDelete {
  static Future deleteClientes(String idCliente) async {
    // Map<String, String> headers = new Map<String, String>();
    // headers["Content-type"] = "application/json";
    // headers["Accept"] = "application/json";

    // String str = '{"Nome" : "pelo app","Cpf" : "123456789","Sexo" : "F"}';

    // var url = baseUrl + "cliente/Salvar";
    // return await http.delete(url, body: str, headers: headers);
  }
}
