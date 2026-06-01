import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroPage extends StatelessWidget {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  Future registrar(BuildContext context) async {
    try {
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtSenha.text,
      );

      txtNome.clear();
      txtEmail.clear();
      txtSenha.clear();

      Navigator.of(context)
        ..pop()
        ..pushReplacementNamed('/home');
    } on FirebaseAuthException catch (ex) {
                  final snackBar = SnackBar(
                    content: Text(ex.message!),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  );
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 7, 128),
        toolbarHeight: 40,
        centerTitle: true,
        // colocar a cor do icone back branco
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.person_add, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Criar Conta',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(50),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Text(
              'Junte-se a nós!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 9, 4, 72),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: txtNome,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Insira seu nome completo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 17, 7, 128),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () => registrar(context),

              child: const Text(
                'Registrar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
