import 'package:flutter/material.dart';
import 'package:nacombi/categorias/services/categoria_services.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/categorias/models/categoria.dart';

class EditarCategoriaPage extends StatelessWidget {
  EditarCategoriaPage({super.key, this.categoria});
  Categoria? categoria;

  //final CategoriaServices _categoriaServices = CategoriaServices();
  final TextEditingController _nomecontroller = TextEditingController();
  final TextEditingController _descricaocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nomecontroller.text = categoria!.nome!;
    _descricaocontroller.text = categoria!.descricao!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categoria'),
        backgroundColor: const Color.fromARGB(255, 219, 132, 235),
        centerTitle: true,
      ),
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
                  id: this.categoria!.id,
                  nome: _nomecontroller.text,
                  descricao: _descricaocontroller.text,
                );
                CategoriaServices cat = CategoriaServices();
                cat.atualizarCategoria(categoria);
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
