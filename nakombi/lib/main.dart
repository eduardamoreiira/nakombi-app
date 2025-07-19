import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/main/main_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var options = const FirebaseOptions(
    apiKey: "AIzaSyCNhq8fLre5d9zFz7T7sn7aH49mOvtapEg",
    authDomain: "nakombi-6e589.firebaseapp.com",
    projectId: "nakombi-6e589",
    storageBucket: "nakombi-6e589.firebasestorage.app",
    messagingSenderId: "1035351711439",
    appId: "1:1035351711439:web:3a86166a6f6cdd983161ba",
    measurementId: "G-XQ45P97V06",
  );
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  } else {
    await Firebase.initializeApp();
  }
  // runApp(const MyApp());
  initializeDateFormatting('pt_BR', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nakombi - Baixa Gastronomia',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            250,
            4,
            176,
          ), //define as cores do app
        ),
      ),
      home: const MainPage(),
    );
  }
}
