// ===============================
// lib/Transaction.dart
// ===============================
// Tela de cadastro de transação

import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  bool isIncome = true;

  void save() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text);

    if (title.isEmpty || value == null) return;

    // Retorna dados para a tela anterior
    Navigator.pop(context, {
      'title': title,
      'value': value,
      'isIncome': isIncome,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),

            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),

            SwitchListTile(
              title: const Text('É receita?'),
              value: isIncome,
              onChanged: (value) {
                setState(() {
                  isIncome = value;
                });
              },
            ),

            ElevatedButton(
              onPressed: save,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
