// ===============================
// lib/App.dart
// ===============================
// Configuração geral do aplicativo
// Define tema, rotas e tela inicial

import 'package:flutter/material.dart';
import 'Login.dart';
import 'Registro.dart';
import 'Home.dart';
import 'Transaction.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove banner de debug
      title: 'Controle MEI',

      // Definição das rotas do aplicativo
      routes: {
        '/': (context) => LoginPage(),
        '/registro': (context) => RegistroPage(),
        '/home': (context) => HomePage(),
        '/transaction': (context) => TransactionPage(),
      },

      initialRoute: '/', // Define a primeira tela
    );
  }
}
