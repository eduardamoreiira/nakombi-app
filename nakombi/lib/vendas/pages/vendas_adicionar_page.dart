import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/commons/my_textformfield.dart';
import 'package:nacombi/commons/theme/app_colors.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/vendas/models/venda.dart';
import 'package:nacombi/clientes/models/cliente.dart';
import 'package:nacombi/commons/my_text.dart';

class VendasAdicionarPage extends StatefulWidget {
  const VendasAdicionarPage({
    super.key,
    required this.diaEvento,
    required this.horario,
    required this.local,
  });
  final DateTime diaEvento;
  final String horario;
  final String local;

  @override
  VendasAdicionarPageState createState() => VendasAdicionarPageState();
}

class VendasAdicionarPageState extends State<VendasAdicionarPage> {
  final _formKey = GlobalKey<FormState>();
  String? _categoria;
  String? _novaCategoria;
  final List<String> _categorias = ['Simples', 'Fiado', 'Outro'];
  Venda venda = Venda();
  Cliente cliente = Cliente();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 3, 45, 5),
                offset: Offset(0.5, 0.5),
                spreadRadius: 1.5,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(),
                ),
                const Center(
                  child: Text(
                    "Adicionar Venda",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Tipo do Cliente",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[400]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _categoria,
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    items:
                        _categorias.map((String categoria) {
                          return DropdownMenuItem<String>(
                            value: categoria,
                            child: Text(categoria),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _categoria = value;
                      });
                    },
                    validator:
                        (value) =>
                            value == null
                                ? 'Por favor, selecione a categoria do cliente'
                                : null,
                  ),
                ),
                if (_categoria == 'Outro') ...[
                  const SizedBox(height: 16),
                  const Text(
                    "Adicionar Categoria",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  MyTextFormField(
                    '', // Provide the required positional argument (adjust as needed)
                    labelText: 'Adicionar Categoria',
                    textType: TextInputType.text,
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   filled: true,
                    //   fillColor: Colors.grey[200],
                    // ),
                    onChanged: (value) {
                      _novaCategoria = value;
                    },
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'Categoria não pode ficar em branco'
                                : null,
                    onSaved: (value) {},
                  ),
                ],
                const SizedBox(height: 16),
                // const Text(
                //   "Nome do Cliente",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                // ),
                // const SizedBox(height: 8),
                MyTextFormField(
                  '', // Provide the required positional argument (adjust as needed)
                  textType: TextInputType.text,
                  labelText: 'Nome do Cliente',
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   filled: true,
                  //   fillColor: Colors.grey[200],
                  // ),
                  onChanged: (value) {
                    cliente.nome = value.toString();
                    debugPrint(value.toString());
                  },
                  onSaved: (value) {
                    cliente.nome = value.toString();

                    venda.cliente = cliente;
                    return null;
                  },
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? 'Por favor, informe o nome do cliente'
                              : null,
                ),
                const SizedBox(height: 16),
                Text(
                  "Local: ${widget.local}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Dia: ${DateFormat("dd/MM/yyyy").format(widget.diaEvento)} - Horário: ${widget.horario}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (_categoria == 'Outro' &&
                            _novaCategoria != null &&
                            _novaCategoria!.isNotEmpty) {
                          _categorias.add(_novaCategoria!);
                          _categoria = _novaCategoria;
                        }
                        venda.data = widget.diaEvento;
                        venda.total = 0;
                        VendasService vendasService = VendasService();
                        vendasService.adicionarVenda(venda);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
