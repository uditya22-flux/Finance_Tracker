import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<MoneyTransaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'No transactions yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (_, i) {
          final tx = transactions[i];
          return ListTile(
            title: Text(tx.category),
            subtitle: Text(tx.note),
            trailing: Text(
              tx.type == TransactionType.expense
                  ? '- ₹${tx.amount}'
                  : '+ ₹${tx.amount}',
            ),
          );
        },
      ),
    );
  }
}

