// ===============================
// lib/Registro.dart
// ===============================
// Tela para cadastro de novo usuário

import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome')),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/'); // Volta para login
              },
              child: const Text('Registrar'),
            )
          ],
        ),
      ),
    );
  }
}
