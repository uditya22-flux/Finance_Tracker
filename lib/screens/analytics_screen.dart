import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class AnalyticsScreen extends StatefulWidget {
  final List<MoneyTransaction> transactions;

  const AnalyticsScreen({
    super.key,
    required this.transactions,
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = 'Monthly';

  // 🔹 Filter transactions
  List<MoneyTransaction> get filteredTransactions {
    final now = DateTime.now();

    if (_selectedPeriod == 'Daily') {
      return widget.transactions.where((t) {
        return t.date.day == now.day &&
            t.date.month == now.month &&
            t.date.year == now.year;
      }).toList();
    }

    if (_selectedPeriod == 'Weekly') {
      return widget.transactions.where((t) {
        return now.difference(t.date).inDays <= 7;
      }).toList();
    }

    // Monthly (default)
    return widget.transactions.where((t) {
      return t.date.month == now.month &&
          t.date.year == now.year;
    }).toList();
  }

  double get totalIncome => filteredTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (s, t) => s + t.amount);

  double get totalExpense => filteredTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (s, t) => s + t.amount);

  double get pocketMoney => filteredTransactions
      .where((t) => t.type == TransactionType.pocketMoney)
      .fold(0, (s, t) => s + t.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Period Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Daily', 'Weekly', 'Monthly'].map((period) {
                final isSelected = _selectedPeriod == period;
                return ChoiceChip(
                  label: Text(period),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // 🔹 Summary Cards
            _SummaryTile(
              label: 'Income',
              amount: totalIncome,
              color: Colors.green,
            ),
            _SummaryTile(
              label: 'Pocket Money',
              amount: pocketMoney,
              color: Colors.blue,
            ),
            _SummaryTile(
              label: 'Expense',
              amount: totalExpense,
              color: Colors.red,
            ),

            const SizedBox(height: 24),

            // 🔹 Insight
            if (filteredTransactions.isEmpty)
              const Text(
                'No data for selected period',
                style: TextStyle(color: Colors.grey),
              )
            else
              Text(
                totalExpense > totalIncome
                    ? '⚠ You are spending more than you earn'
                    : '✅ Your finances look balanced',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Small reusable widget
class _SummaryTile extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(label),
        trailing: Text(
          '₹ ${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
