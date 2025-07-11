import 'package:flutter/material.dart';
import 'package:nacombi/clientes/service/cliente_services.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';

class EditarClientePage extends StatelessWidget {
  EditarClientePage({super.key, this.cliente});

  ClienteModel? cliente;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nomeController.text = cliente!.nome!;
    _emailController.text = cliente!.email!;
    _cpfController.text = cliente!.cpf!;

    return Scaffold(
      appBar: AppBar(title: Text('Editar Cliente'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextFormField('Nome', controller: _nomeController),
            MyTextFormField('Email', controller: _emailController),
            MyTextFormField('CPF', controller: _cpfController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ClienteModel updatedCliente = cliente!.copyWith(
                  nome: _nomeController.text,
                  email: _emailController.text,
                  cpf: _cpfController.text,
                );
                ClienteServices().atualizarCliente(updatedCliente);
              },
              child: Text('Confirmar Alteração'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
