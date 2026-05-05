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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove banner de debug
      title: 'Controle MEI',

      // Definição das rotas do aplicativo
      routes: {
        '/': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
        '/home': (context) => const HomePage(),
        '/transaction': (context) => const TransactionPage(),
      },

      initialRoute: '/', // Define a primeira tela
    );
  }
}
