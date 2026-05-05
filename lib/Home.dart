// ===============================
// lib/Home.dart
// ===============================
// Tela principal - mostra saldo e lista de transações

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> transactions = []; // Lista simples

  double get balance {
    double total = 0;
    for (var t in transactions) {
      total += t['isIncome'] ? t['value'] : -t['value'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),

      body: Column(
        children: [
          // Exibição do saldo
          Text('Saldo: R\$ ${balance.toStringAsFixed(2)}'),

          // Lista de transações
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final t = transactions[index];
                return ListTile(
                  title: Text(t['title']),
                  trailing: Text('R\$ ${t['value']}'),
                );
              },
            ),
          ),

          // Botão para ir para cadastro de transação
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/transaction');

              // Recebe dados da tela de transação
              if (result != null) {
                setState(() {
                  transactions.add(result as Map<String, dynamic>);
                });
              }
            },
            child: const Text('Nova Transação'),
          )
        ],
      ),
    );
  }
}
