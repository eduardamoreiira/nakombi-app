import 'package:flutter/material.dart';
import 'package:nacombi/categoria/models/categoria.dart';
import 'package:nacombi/categoria/services/categoria_services.dart';
import 'package:nacombi/commons/my_textformfield.dart';

class CategoriaEditarPage extends StatelessWidget {
  CategoriaEditarPage({super.key, this.categoria});
  Categoria? categoria;
  //controladores para interação com os campos textos
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nomeController.text = categoria?.nome ?? '';
    descricaoController.text = categoria?.descricao ?? '';
    return Scaffold(
      appBar: AppBar(title: Text('Categoria')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: Column(
          children: [
            MyTextFormField(
              'Nome',
              controller: nomeController,
              textType: TextInputType.text,
              labelText: '',
              onChanged: (value) {},
              validator: (value) {
                return null;
              },
              onSaved: (value) {},
            ),
            MyTextFormField(
              'Descrição',
              controller: descricaoController,
              textType: TextInputType.text,
              labelText: '',
              onChanged: (value) {},
              validator: (value) {
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Categoria categoria = Categoria(
                  id: this.categoria!.id,
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                );
                CategoriaServices cat = CategoriaServices();
                cat.atualizarCategoria(categoria);
              },
              child: Text('Confirmar alteração'),
            ),
          ],
        ),
      ),
    );
  }
}
