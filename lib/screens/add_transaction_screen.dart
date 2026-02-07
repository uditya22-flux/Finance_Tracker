import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _customCategoryController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;

  final List<String> _categories = [
    'Food',
    'Travel',
    'Shopping',
    'Rent',
    'Education',
    'Entertainment',
  ];

  String? _selectedCategory;
  bool _isCustomCategory = false;

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text);

    final category = _isCustomCategory
        ? _customCategoryController.text.trim()
        : _selectedCategory;

    if (amount == null || category == null || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter amount and category')),
      );
      return;
    }

    final tx = MoneyTransaction(
      amount: amount,
      category: category,
      note: _noteController.text.trim(),
      date: DateTime.now(),
      type: _selectedType,
    );

    Navigator.pop(context, tx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Amount
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),

              const SizedBox(height: 12),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                items: [
                  ..._categories.map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ),
                  ),
                  const DropdownMenuItem(
                    value: 'custom',
                    child: Text('+ Add new category'),
                  ),
                ],
                onChanged: (value) {
                  if (value == 'custom') {
                    setState(() {
                      _isCustomCategory = true;
                      _selectedCategory = null;
                    });
                  } else {
                    setState(() {
                      _isCustomCategory = false;
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              if (_isCustomCategory) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _customCategoryController,
                  decoration:
                      const InputDecoration(labelText: 'New Category'),
                ),
              ],

              const SizedBox(height: 12),

              // Note
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),

              const SizedBox(height: 12),

              // Transaction Type
              DropdownButtonFormField<TransactionType>(
                value: _selectedType,
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text('Expense'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text('Income'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.pocketMoney,
                    child: Text('Pocket Money'),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _selectedType = v);
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveTransaction,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

