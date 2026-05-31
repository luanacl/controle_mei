import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<TransactionPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  String tipo = "entrada";
  String categoria = "Vendas";

  String uid = FirebaseAuth.instance.currentUser!.uid;

  QueryDocumentSnapshot? doc;
  bool dadosCarregados = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (dadosCarregados) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      doc = args as QueryDocumentSnapshot;

      nomeController.text = doc!["nome"];
      valorController.text = doc!["valor"].toString();

      tipo = doc!["tipo"];
      categoria = doc!["categoria"];
    }

    dadosCarregados = true;
  }

  Future salvar() async {
    if (nomeController.text.trim().isEmpty ||
        valorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    double? valor = double.tryParse(
      valorController.text.replaceAll(',', '.'),
    );

    if (valor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite um valor válido"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (doc != null) {
      await FirebaseFirestore.instance
          .collection("transactions")
          .doc(doc!.id)
          .update({
        "nome": nomeController.text.trim(),
        "valor": valor,
        "tipo": tipo,
        "categoria": categoria,
      });
    } else {
      await FirebaseFirestore.instance
          .collection("transactions")
          .add({
        "uid": uid,
        "nome": nomeController.text.trim(),
        "valor": valor,
        "tipo": tipo,
        "categoria": categoria,
        "createdAt": Timestamp.now(),
      });
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool editando = doc != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          17,
          7,
          128,
        ),

        toolbarHeight: 40,

        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 20,
            ),

            const SizedBox(width: 8),

            Text(
              editando
                  ? "Editar Movimentação"
                  : "Nova Movimentação",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 4,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  TextField(
                    controller: nomeController,

                    decoration: InputDecoration(
                      labelText: "Descrição",

                      prefixIcon: const Icon(
                        Icons.description,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: valorController,

                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    decoration: InputDecoration(
                      labelText: "Valor",

                      prefixText: "R\$ ",

                      prefixIcon: const Icon(
                        Icons.attach_money,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: tipo,

                    decoration: InputDecoration(
                      labelText: "Tipo",

                      prefixIcon: Icon(
                        tipo == "entrada"
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

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
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: categoria,

                    decoration: InputDecoration(
                      labelText: "Categoria",

                      prefixIcon: const Icon(
                        Icons.category,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: "Vendas",
                        child: Text("Vendas"),
                      ),

                      DropdownMenuItem(
                        value: "Fornecedores",
                        child: Text("Fornecedores"),
                      ),

                      DropdownMenuItem(
                        value: "Matéria Prima",
                        child: Text("Matéria Prima"),
                      ),

                      DropdownMenuItem(
                        value: "Empréstimos",
                        child: Text("Empréstimos"),
                      ),

                      DropdownMenuItem(
                        value: "Custos Fixos",
                        child: Text("Custos Fixos"),
                      ),

                      DropdownMenuItem(
                        value: "Outros",
                         child: Text("Outros")
                      ),

                    ],

                    onChanged: (value) {
                      setState(() {
                        categoria = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(
                          255,
                          17,
                          7,
                          128,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),

                      onPressed: salvar,

                      child: Text(
                        editando
                            ? "ATUALIZAR"
                            : "ADICIONAR",

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}