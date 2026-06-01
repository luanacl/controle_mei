import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 7, 128),
        toolbarHeight: 40,
        centerTitle: true,

        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.login, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                  ),
                ),

            const SizedBox(height: 30),
            // Texto de boas vindas
            Text(
              'Bem vindo de volta!',
              textAlign: TextAlign.center,
              style: (TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 17, 7, 128),
              )),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Entre em sua conta',
              textAlign: TextAlign.center,
              style: (TextStyle(color: Color.fromARGB(255, 100, 100, 100))),
            ),
            const SizedBox(height: 48.0),

            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Insira seu email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: txtSenha,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Insira sua senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 17, 7, 128),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: txtEmail.text,
                    password: txtSenha.text,
                  );
                  Navigator.pushReplacementNamed(context, "/home");
                } on FirebaseAuthException catch (ex) {
                  final snackBar = SnackBar(
                    content: Text(ex.message!),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                'Entrar',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 17, 7, 128),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
              child: const Text(
                'Criar Conta',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
