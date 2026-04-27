// ===============================
// lib/Login.dart
// ===============================
// Tela de login do usuário

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true, // Esconde a senha
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Vai para Home
              },
              child: const Text('Entrar'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registro'); // Vai para Registro
              },
              child: const Text('Criar conta'),
            )
          ],
        ),
      ),
    );
  }
}
