import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sary/Models/Transactions.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [];

  final String _dbKey = 'transactionList';
  Box<dynamic>? _db;

  List<Transaction> get transactions => _transactions;

  Transactions(Box<dynamic> db) {
    _db = db;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    _db!.put(_dbKey, _transactions);
    notifyListeners();
  }

  void deleteTransaction(Transaction item) {
    _transactions.remove(item);
    _db!.put(_dbKey, _transactions);
    notifyListeners();
  }

  Transaction? getTransaction(int id) {
    Transaction? transaction;
    _transactions.forEach((element) {
      element.id == id ? transaction = element : null;
    });
    return transaction;
  }
}
