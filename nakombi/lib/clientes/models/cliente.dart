// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  String? id;
  String? nome;
  String? cpf;
  String? email;
  String? categoria;

  Cliente({this.id, this.nome, this.cpf, this.email, this.categoria});

  Cliente copyWith({
    String? id,
    String? nome,
    String? cpf,
    String? email,
    String? categoria,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      categoria: categoria ?? this.categoria,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (nome != null) {
      result.addAll({'nome': nome});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (categoria != null) {
      result.addAll({'tipo': categoria});
    }

    return result;
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      email: map['email'],
      categoria: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cliente(id: $id, nome: $nome, cpf: $cpf, email: $email, tipo: $categoria)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cliente &&
        other.id == id &&
        other.nome == nome &&
        other.cpf == cpf &&
        other.email == email &&
        other.categoria == categoria;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        cpf.hashCode ^
        email.hashCode ^
        categoria.hashCode;
  }
}
