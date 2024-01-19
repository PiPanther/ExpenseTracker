import 'package:expenset/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.deepPurpleAccent,
      color: Color.fromARGB(239, 30, 241, 210),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 4,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Rs." + expense.amount.toString(), style: TextStyle(fontSize: 14),),
                  Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      SizedBox(
                        width: 14,
                      ),
                      Text(expense.formattedDate),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
