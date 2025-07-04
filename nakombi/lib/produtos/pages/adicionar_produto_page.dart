import 'package:flutter/material.dart';
import 'package:nacombi/produtos/service/produto_service.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/categorias/models/categoria.dart';

class AdicionarProdutoPage extends StatelessWidget {
  AdicionarProdutoPage({super.key});

  final ProdutoService _produtoService = ProdutoService();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _estoqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Produto'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextFormField('Nome', controller: _nomeController),
            MyTextFormField('Descrição', controller: _descricaoController),
            MyTextFormField('Preço', controller: _precoController),
            MyTextFormField('Estoque', controller: _estoqueController),
            MyTextFormField('Marca', controller: _marcaController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ProdutoService prod = ProdutoService();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
