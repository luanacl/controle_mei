import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<TransactionPage> {
  // CONTROLLERS
  TextEditingController nomeController = TextEditingController();

  TextEditingController valorController = TextEditingController();

  // VALORES INICIAIS
  String tipo = "entrada";

  String categoria = "Vendas";

  String uid = FirebaseAuth.instance.currentUser!.uid;

  // FUNCAO PARA SALVAR
  Future salvar() async {
    // PEGA O VALOR DIGITADO
    double valor = double.parse(valorController.text);

    // SALVA NO FIREBASE
    await FirebaseFirestore.instance.collection("transactions").add({
      "uid": uid,

      "nome": nomeController.text,

      "valor": valor,

      "tipo": tipo,

      "categoria": categoria,

      "createdAt": Timestamp.now(),
    });

    // VOLTA PARA HOME
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 7, 128),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 40,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Nova Transação',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NOME
            TextField(
              controller: nomeController,

              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // VALOR
            TextField(
              controller: valorController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // TIPO
            DropdownButtonFormField(
              initialValue: tipo,

              items: const [
                DropdownMenuItem(value: "entrada", child: Text("Entrada")),

                DropdownMenuItem(value: "saida", child: Text("Saída")),
              ],

              onChanged: (value) {
                setState(() {
                  tipo = value!;
                });
              },

              decoration: const InputDecoration(
                labelText: "Tipo",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORIA
            DropdownButtonFormField(
              value: categoria,

              items: const [
                DropdownMenuItem(value: "Vendas", child: Text("Vendas")),

                DropdownMenuItem(value: "Comissões", child: Text("Comissões")),

                DropdownMenuItem(
                  value: "Fornecedores",
                  child: Text("Fornecedores"),
                ),

                DropdownMenuItem(
                  value: "Empréstimos",
                  child: Text("Empréstimos"),
                ),

                DropdownMenuItem(value: "Impostos", child: Text("Impostos")),

                DropdownMenuItem(
                  value: "Transporte",
                  child: Text("Transporte"),
                ),

                DropdownMenuItem(
                  value: "Custos Fixos",
                  child: Text("Custos Fixos"),
                ),

                DropdownMenuItem(value: "Outros", child: Text("Outros")),
              ],

              onChanged: (value) {
                setState(() {
                  categoria = value!;
                });
              },

              decoration: const InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // BOTAO
            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 17, 7, 128),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: salvar,

                child: const Text(
                  "Adicionar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
