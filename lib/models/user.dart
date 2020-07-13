class User {
  int idCliente;
  String nome;
  String cpf;
  String dataNascimento;
  String sexo;

  User({this.idCliente, this.nome, this.cpf, this.dataNascimento, this.sexo});

  User.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nome = json['nome'];
    cpf = json['cpf'];
    dataNascimento = json['dataNascimento'];
    sexo = json['sexo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCliente'] = this.idCliente;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['dataNascimento'] = this.dataNascimento;
    data['sexo'] = this.sexo;
    return data;
  }
}
