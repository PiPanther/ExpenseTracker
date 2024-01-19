import 'package:expenset/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
      theme: ThemeData().copyWith(useMaterial3: true, cardTheme: CardTheme(margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6))),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    );
  }
}
