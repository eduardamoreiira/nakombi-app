// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClienteModel {
  String? id;
  String? nome;
  String? cpf;
  String? email;
  ClienteModel({this.id, this.nome, this.cpf, this.email});

  ClienteModel copyWith({
    String? id,
    String? nome,
    String? cpf,
    String? email,
  }) {
    return ClienteModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClienteModel(id: $id, nome: $nome, cpf: $cpf, email: $email)';
  }

  @override
  bool operator ==(covariant ClienteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.cpf == cpf &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ cpf.hashCode ^ email.hashCode;
  }
}
