import 'package:flutter/material.dart';

class AddClientPage extends StatelessWidget {
  const AddClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Cliente')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
        child: Column(
          children: [
            // MyTextFormField('Nome'),
            // MyTextFormField('Endereço'),
            // MyTextFormField('Telefone'),
            // MyTextFormField('CEP'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddClientPage()));
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddClientPage()));
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
