import 'package:flutter/material.dart';
import 'package:nacombi/categorias/pages/adicionar_categoria.dart';
import 'package:nacombi/categorias/pages/lista_categoria_page.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';
import 'package:nacombi/clientes/pages/lista_clientes_page.dart';
import 'package:nacombi/clientes/pages/profile_page.dart';
import 'package:nacombi/caixa/pages/lista_caixa_page.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
//retorna para a aplicação a tela inicial
//Scaffold é um widget que fornece uma estrutura básica para a tela

class _MainPageState extends State<MainPage> {
  bool isSelected = false; //variável para controlar o estado do ExpansionTile
  int _index = 0; //variável para controlar o índice da tela inicial
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nakombi Baixa Gastronomia Cuiabana'),
      ),
      body:
          [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCard(
                      'Vendas',
                      'registrar',
                      Colors.purple,
                      Colors.purpleAccent,
                      child: Column(),
                    ),
                    SizedBox(height: 20),
                    MyCard(
                      'Locais',
                      'regiões',
                      Colors.pink,
                      Colors.pinkAccent,
                      child: Column(),
                    ),
                    SizedBox(height: 20),
                    MyCard(
                      'Clientes',
                      'quantidade',
                      Colors.blue,
                      Colors.blueAccent,
                      child: Column(),
                    ),
                  ],
                ),
              ),
            ),
            ListaCaixaPage(),
            Container(color: Colors.blueAccent),
            ProfilePage(),
          ][_index], //aqui adicionar o conteúdo da tela inicial
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value; //atualiza o índice da tela inicial
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
      drawer: Drawer(
        width: 250,
        child: SafeArea(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(
                      'assets/logo/kombi.jpeg',
                      width: 50,
                      height: 50,
                    ),
                    //SvgPicture.asset('assets/logo/Logo.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Nakombi Gastro',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: TextTheme.of(context).bodyMedium!.color,
                      ),
                    ),
                    //SvgPicture.asset('assets/logo/Logo.svg'),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        shape: Border(),
                        initiallyExpanded: isSelected,
                        leading: SvgPicture.asset(
                          isSelected
                              ? 'assets/icons/home_filled.svg'
                              : 'assets/icons/home_light.svg',
                        ),
                        onExpansionChanged: (value) {
                          setState(() {
                            isSelected = value;
                          });
                        },
                        title: Text(
                          'Gerenciamento',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: TextTheme.of(context).bodyMedium!.color,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ListaCategoriaPage(),
                                  ),
                                );
                              },
                              title: Text(
                                'Categorias',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: TextTheme.of(context).bodySmall!.color,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ListaCategoriaPage(),
                                  ),
                                );
                              },
                              title: Text(
                                'Clientes',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.color,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ListaClientesPage(), // ou a tela correta de listagem de clientes
                                  ),
                                );
                              },
                              title: Text(
                                'Produtos',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.people),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Perfil de Usuário',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.shop),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Vendas',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.shop),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Pedidos',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
