import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Perfil do Usuário'),
        Divider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(children: [TextFormField(
               decoration: InputDecoration(
                  labelText: 'Nome do Usuário',
                  labelStyle: TextStyle(color: Colors.teal),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ), 
              SizedBox(height: 10),
              TextFormField(
               decoration: InputDecoration(
                  labelText: 'E-mail do Usuário',
                  labelStyle: TextStyle(color: Colors.teal),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ), 
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.teal),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(onPressed: () {}, child: Text('Salvar')),]),
            ],
          ),
        )
      ],
    );
  }
}