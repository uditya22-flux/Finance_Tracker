import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'add_transaction_screen.dart';
import '../widgets/balance_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MoneyTransaction> _transactions = [];
  int _selectedIndex = 0;

  // 🔹 totals
  double get income => _transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (s, t) => s + t.amount);

  double get expense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (s, t) => s + t.amount);

  double get pocketMoney => _transactions
      .where((t) => t.type == TransactionType.pocketMoney)
      .fold(0, (s, t) => s + t.amount);

  Future<void> _addTransaction() async {
    final result = await Navigator.push<MoneyTransaction>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddTransactionScreen(),
      ),
    );

    if (result != null) {
      setState(() => _transactions.add(result));
    }
  }

  // 🔹 HOME TAB
  Widget _homeTab() {
    return Column(
      children: [
        BalanceCard(
          income: income,
          expense: expense,
          pocketMoney: pocketMoney,
        ),
        Expanded(
          child: _transactions.isEmpty
              ? const Center(
                  child: Text(
                    'No transactions yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (_, i) {
                    final tx = _transactions[i];
                    return ListTile(
                      title: Text(tx.category),
                      subtitle: Text(tx.note),
                      trailing: Text(
                        tx.type == TransactionType.expense
                            ? '- ₹${tx.amount}'
                            : '+ ₹${tx.amount}',
                        style: TextStyle(
                          color: tx.type == TransactionType.expense
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // 🔹 BODY SWITCH
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _homeTab();
      case 1:
        return const Center(child: Text('Analytics (Coming Soon)'));
      case 2:
        return const Center(child: Text('Settings (Coming Soon)'));
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Finances'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: _buildBody(),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        selectedItemColor: const Color(0xFF6C63FF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

