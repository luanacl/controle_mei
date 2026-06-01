import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String tipo =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 7, 128),
        title: Text(
          tipo == "entrada" ? "Entradas" : "Saídas",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("transactions")
            .where(
              "uid",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )
            .where("tipo", isEqualTo: tipo)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text("Nenhum registro encontrado"),
            );
          }

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder: (context, index) {

              var doc = docs[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(
                  title: Text(doc["nome"]),
                  subtitle: Text(doc["categoria"]),

                  trailing: Text(
                    "R\$ ${doc["valor"]}",
                  ),

                  onTap: () {
                    mostrarOpcoes(
                      context,
                      doc,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void mostrarOpcoes(
    BuildContext context,
    QueryDocumentSnapshot doc,
  ) {

    showModalBottomSheet(
      context: context,

      builder: (context) {
        return SafeArea(
        child: Wrap(
          children: [

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Editar"),

              onTap: () {

                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  "/transaction",
                  arguments: doc,
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Excluir"),

              onTap: () async {

                await FirebaseFirestore.instance
                    .collection("transactions")
                    .doc(doc.id)
                    .delete();

                Navigator.pop(context);
              },
            ),
          ],
        ),
        );
      },
    );
  }
}