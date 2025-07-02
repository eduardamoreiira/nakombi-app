import 'package:flutter/material.dart';
import 'package:nacombi/clientes/service/cliente_services.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';

class AdicionarClientePage extends StatelessWidget {
  AdicionarClientePage({super.key});

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Cliente'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextFormField('Nome', controller: _nomeController),
            MyTextFormField('Email', controller: _emailController),
            MyTextFormField(
              'CPF',
              controller: _cpfController,
              initialValue: '000.000.000-00', // Placeholder for CPF
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ClienteModel cliente = ClienteModel(
                  nome: _nomeController.text,
                  email: _emailController.text,
                  cpf: _cpfController.text,
                );
                ClienteServices().adicionarCliente(cliente);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
