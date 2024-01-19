import 'package:expenset/main.dart';
import 'package:expenset/widgets/charts/chart.dart';
import 'package:expenset/widgets/expense_list/expenses_list.dart';
import 'package:expenset/models/expense.dart';
import 'package:expenset/widgets/newExpense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        category: Category.food,
        amount: 12,
        title: 'Flutter Course',
        date: DateTime.now()),
    Expense(
        category: Category.food,
        amount: 12,
        title: 'Flutter Course',
        date: DateTime.now()),
  ];

  void addExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85),
        context: context,
        builder: (context) {
          return NewExpenses(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found, Start adding some.'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: addExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          SizedBox(
            height: 10,
          ),
          const Text(
            'Your Expenses',
            style: TextStyle(
                color: Color.fromARGB(255, 103, 236, 236),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14,
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
