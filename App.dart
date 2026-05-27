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
      debugShowCheckedModeBanner: false,
      title: 'Controle MEI',

      routes: {
        '/': (context) => LoginPage(),
        '/registro': (context) => RegistroPage(),
        '/home': (context) => HomePage(),
        '/transaction': (context) => TransactionPage(),
      },

      initialRoute: '/',
    );
  }
}
