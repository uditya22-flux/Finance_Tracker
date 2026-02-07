import 'package:flutter/material.dart';
import 'add_transaction_screen.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 TOP BAR
      appBar: AppBar(
        title: const Text('My Finances'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // 🔹 MAIN BODY
      body: Column(
        children: const [
          BalanceCard(),
          TransactionList(),
          SizedBox(height: 20),
          Text(
            'Dashboard below (coming next)',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),

      // 🔹 ADD BUTTON
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTransactionScreen(),
            ),
          );
        },
      ),
    );
  }
}


