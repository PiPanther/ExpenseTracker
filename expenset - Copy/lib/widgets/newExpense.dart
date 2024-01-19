import 'package:expenset/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a title, amount, date and category was entered!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Okay"),
                ),
              ],
            );
          });
      return;
    }
    widget.onAddExpense(Expense(
        category: selectedCategory,
        amount: enteredAmount,
        title: titleController.text,
        date: selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 256, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLength: 60,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    // maxLength: 10,
                    decoration: InputDecoration(
                      prefixText: 'Rs. ',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(selectedDate == null
                          ? 'No date selected'
                          : formatter.format(selectedDate!)),
                      SizedBox(
                        width: 12,
                      ),
                      IconButton(
                          onPressed: () {
                            _presentDatePicker();
                          },
                          icon: Icon(Icons.calendar_month_outlined)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                DropdownButton(
                    value: selectedCategory,
                    items: Category.values
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name.toUpperCase())))
                        .toList(),
                    onChanged: (e) {
                      if (e == null) {
                        return;
                      }
                      setState(() {
                        selectedCategory = e;
                      });
                    }),
                Spacer(),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 103, 236, 236),),)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 103, 236, 236),
                    )),
                    onPressed: _submitExpenseData,
                    child: Text('Save Expense', style: TextStyle(color: Colors.black),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
