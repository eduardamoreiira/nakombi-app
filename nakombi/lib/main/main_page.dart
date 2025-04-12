import 'package:flutter/material.dart';
import 'package:nacombi/clientes/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
//retorna para a aplicação a tela inicial
// Scaffold é um widget que fornece uma estrutura básica para a tela

class _MainPageState extends State<MainPage> {
  int _index = 0; // Variável para controlar o índice da tela inicial
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nakombi Baixa Gastronomia Cuiabana'),
      ),
      body:
          [
            Container(color: Colors.amberAccent),
            Container(color: Colors.greenAccent),
            Container(color: Colors.blueAccent),
            ProfilePage(),
          ][_index], // Aqui você pode adicionar o conteúdo da tela inicial
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value; // Atualiza o índice da tela inicial
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Vendas',
          ),
          NavigationDestination(icon: Icon(Icons.list), label: 'Relatórios'),
          NavigationDestination(
            icon: Icon(Icons.person_2),
            label: 'Perfil de Usuário',
          ),
        ],
      ),
    );
  }
}
