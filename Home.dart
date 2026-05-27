import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 7, 128),
        toolbarHeight: 40,

        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),

        title: const Text(
          "Controle MEI",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),

      // BOTAO +
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          17,
          7,
          128,
        ), // Cor do fundo do botão
        foregroundColor: Colors.white, // Cor do ícone de "+"
        onPressed: () {
          Navigator.pushNamed(context, "/transaction");
        },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("transactions")
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),

        builder: (context, snapshot) {
          // ENQUANTO CARREGA
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // PEGA TODOS OS DOCUMENTOS
          var docs = snapshot.data!.docs;

          double entradas = 0;
          double saidas = 0;

          // SOMA OS VALORES
          for (var doc in docs) {
            var data = doc.data();

            double valor = data["valor"];
            String tipo = data["tipo"];

            if (tipo == "entrada") {
              entradas += valor;
            } else {
              saidas += valor;
            }
          }

          double total = entradas - saidas;

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                // GRAFICO
                Container(
                  height: 250,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,

                      centerSpaceRadius: 40,

                      sections: [
                        // ENTRADAS
                        PieChartSectionData(
                          value: entradas,

                          color: Colors.green,

                          radius: 60,

                          title: "Entradas",

                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // SAIDAS
                        PieChartSectionData(
                          value: saidas,

                          color: Colors.red,

                          radius: 60,

                          title: "Saídas",

                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ENTRADAS
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_downward,
                      color: Colors.green,
                    ),

                    title: const Text("Entradas"),

                    trailing: Text(
                      "R\$ ${entradas.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // SAIDAS
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.arrow_upward, color: Colors.red),

                    title: const Text("Saídas"),

                    trailing: Text(
                      "R\$ ${saidas.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // TOTAL
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.blue,
                    ),

                    title: const Text("Total"),

                    trailing: Text(
                      "R\$ ${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
