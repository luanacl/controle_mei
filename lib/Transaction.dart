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
    await FirebaseFirestore.instance
        .collection("transactions")
        .add({

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
        title: const Text("Nova movimentação"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
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

                DropdownMenuItem(
                  value: "entrada",
                  child: Text("Entrada"),
                ),

                DropdownMenuItem(
                  value: "saida",
                  child: Text("Saída"),
                ),
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

                DropdownMenuItem(
                  value: "Vendas",
                  child: Text("Vendas"),
                ),

                DropdownMenuItem(
                  value: "Serviços",
                  child: Text("Serviços"),
                ),

                DropdownMenuItem(
                  value: "Matéria Prima",
                  child: Text("Matéria Prima"),
                ),

                DropdownMenuItem(
                  value: "Custos Fixos",
                  child: Text("Custos Fixos"),
                ),
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
                onPressed: salvar,

                child: const Text(
                  "SALVAR",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}