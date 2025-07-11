import 'package:flutter/material.dart';
import 'package:nacombi/categorias/services/categoria_services.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/categorias/models/categoria.dart';

class AdicionarCategoria extends StatelessWidget {
  AdicionarCategoria({super.key});

  //final CategoriaServices _categoriaServices = CategoriaServices();
  final TextEditingController _nomecontroller = TextEditingController();
  final TextEditingController _descricaocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Categoria'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextFormField('Nome', controller: _nomecontroller),
            MyTextFormField('Descrição', controller: _descricaocontroller),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Categoria categoria = Categoria(
                  nome: _nomecontroller.text,
                  descricao: _descricaocontroller.text,
                );
                CategoriaServices cat = CategoriaServices();
                cat.adicionarCategoria(categoria);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
