import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/commons/my_text.dart';

class EditarCaixaPage extends StatefulWidget {
  final Caixa caixaParaEditar;

  const EditarCaixaPage({super.key, required this.caixaParaEditar});

  @override
  State<EditarCaixaPage> createState() => _EditarCaixaPageState();
}

class _EditarCaixaPageState extends State<EditarCaixaPage> {
  final formKey = GlobalKey<FormState>();
  DateTime? _dia;
  TimeOfDay? _horarioSelecionado; // Changed to TimeOfDay?
  DateFormat data = DateFormat("dd/MM/yyyy");
  final TextEditingController _diaEscolhido = TextEditingController();
  final TextEditingController _local = TextEditingController();
  final TextEditingController _horario = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dia = widget.caixaParaEditar.dataEvento;
    _diaEscolhido.text = data.format(_dia!);
    _horarioSelecionado = widget.caixaParaEditar.horario;
    _horario.text = _formatTimeOfDay(_horarioSelecionado!);
    _local.text = widget.caixaParaEditar.local!;
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // e.g., 5:08 PM
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    CaixaServices caixaServices = CaixaServices();

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Caixa')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dia do Evento",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      context: context,
                      initialDate: _dia ?? DateTime.now(),
                    );

                    if (pickedDate != null && pickedDate != _dia) {
                      setState(() {
                        _dia = pickedDate;
                        _diaEscolhido.text = data.format(_dia!);
                      });
                    }
                  },
                  controller: _diaEscolhido,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.green[50],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, preencha o dia do evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Horário do Evento",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _horario,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.green[50],
                  ),
                  onTap: () async {
                    TimeOfDay? hora = await showTimePicker(
                      context: context,
                      initialTime: _horarioSelecionado ?? TimeOfDay.now(),
                    );
                    if (hora != null && hora != _horarioSelecionado) {
                      setState(() {
                        _horarioSelecionado = hora;
                        _horario.text = _formatTimeOfDay(_horarioSelecionado!);
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, preencha o horário do evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Local",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _local,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.green[50],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Local é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Caixa caixaAtualizado = Caixa(
                          id: widget.caixaParaEditar.id,
                          dataEvento: _dia!,
                          horario: _horarioSelecionado!,
                          local: _local.text,
                        );
                        caixaServices.editarCaixa(caixaAtualizado);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.blueGrey,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Salvar Alterações',
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
