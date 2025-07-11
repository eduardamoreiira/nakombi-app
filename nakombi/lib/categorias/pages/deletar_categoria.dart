import 'package:flutter/material.dart';
import 'package:nacombi/categorias/services/categoria_services.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/categorias/models/categoria.dart';

class CategoriaDeletarPage extends StatelessWidget {
  CategoriaDeletarPage({super.key, this.categoria});
  Categoria? categoria;

  //controladores para os campos de texto
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nomeController.text = categoria!.nome!;
    descricaoController.text = categoria!.descricao!;
    return Scaffold(
      appBar: AppBar(title: Text('Categoria')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: Column(
          children: [
            MyTextFormField('Nome', controller: nomeController),
            MyTextFormField('Descrição', controller: descricaoController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Categoria categoria = Categoria(
                  id: this.categoria!.id,
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                );
                CategoriaServices cat = CategoriaServices();
                cat.excluirCategoria(categoria);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Categoria excluida com sucesso!')),
                );
              },
              child: Text('Salvar Categoria'),
            ),
          ],
        ),
      ),
    );
  }
}
