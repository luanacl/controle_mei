import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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

        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

            Navigator.pushReplacementNamed(
              context,
              '/',
            );
          },
        ),

        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 20,
            ),

            SizedBox(width: 8),

            Text(
              "Controle MEI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),

        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          17,
          7,
          128,
        ),

        foregroundColor: Colors.white,

        onPressed: () {
          Navigator.pushNamed(
            context,
            "/transaction",
          );
        },

        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("transactions")
            .where(
              "uid",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Nenhuma movimentação cadastrada",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Clique no botão + para começar",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          double entradas = 0;
          double saidas = 0;

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
          double movimentado = entradas + saidas;

          double porcentagemEntradas = 0;
          double porcentagemSaidas = 0;

          if (movimentado > 0) {
            porcentagemEntradas =
                (entradas / movimentado) * 100;

            porcentagemSaidas =
                (saidas / movimentado) * 100;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                // GRAFICO
                Card(
                  elevation: 5,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: SizedBox(
                    height: 260,

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 50,

                          sections: [
                            PieChartSectionData(
                              value: entradas,
                              color: Colors.green,
                              radius: 70,
                              title: "${porcentagemEntradas.toStringAsFixed(0)}%",

                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            PieChartSectionData(
                              value: saidas,
                              color: Colors.red,
                              radius: 70,
                              title: "${porcentagemSaidas.toStringAsFixed(0)}%",

                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ENTRADAS
                Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/transactions-list",
                        arguments: "entrada",
                      );
                    },

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),

                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),
                    ),

                    title: const Text(
                      "Entradas",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: const Text(
                      "Ver movimentações",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "R\$ ${entradas.toStringAsFixed(2)}",

                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // SAIDAS
                Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/transactions-list",
                        arguments: "saida",
                      );
                    },

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEBEE),

                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      ),
                    ),

                    title: const Text(
                      "Saídas",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: const Text(
                      "Ver movimentações",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "R\$ ${saidas.toStringAsFixed(2)}",

                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // TOTAL
                Card(
                  elevation: 4,

                  color: const Color.fromARGB(
                    255,
                    17,
                    7,
                    128,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                    ),

                    title: const Text(
                      "Saldo Atual",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    trailing: Text(
                      "R\$ ${total.toStringAsFixed(2)}",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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