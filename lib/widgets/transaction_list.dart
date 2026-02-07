import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          _TransactionTile(
            title: 'Food',
            subtitle: 'Lunch at cafeteria',
            amount: '- ₹450',
            color: Colors.red,
          ),
          _TransactionTile(
            title: 'Pocket Money',
            subtitle: 'Weekly allowance',
            amount: '+ ₹1500',
            color: Colors.green,
          ),
          _TransactionTile(
            title: 'Transport',
            subtitle: 'Bus fare',
            amount: '- ₹200',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  const _TransactionTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
