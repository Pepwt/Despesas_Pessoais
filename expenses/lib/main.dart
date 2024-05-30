import 'package:expenses/components/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, VoidCallback fnn) {
    if (kIsWeb) {
      return IconButton(icon: Icon(icon), onPressed: fnn);
    } else if (Platform.isIOS) {
      return GestureDetector(onTap: fnn, child: Icon(icon));
    } else {
      return IconButton(icon: Icon(icon), onPressed: fnn);
    }
  }

  double _getAppBarHeight() {
    if (kIsWeb) {
      return AppBar().preferredSize.height;
    } else if (Platform.isIOS) {
      return 44.0; 
    } else {
      return AppBar().preferredSize.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        kIsWeb ? Icons.add : Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = kIsWeb
        ? AppBar(
            title: Text('Despesas Pessoais'),
            backgroundColor: Colors.purple[600],
            actions: actions,
          )
        : Platform.isIOS
            ? CupertinoNavigationBar(
                middle: Text('Despesas Pessoais'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
              )
            : AppBar(
                title: Text('Despesas Pessoais'),
                backgroundColor: Colors.purple[600],
                actions: actions,
              );

    final availableHeight = mediaQuery.size.height -
        _getAppBarHeight() -
        mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 0.8 : 0.3),
              child: Chart(_recentTransactions),
            ),
          if (!_showChart || !isLandscape)
            Container(
              height: availableHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return kIsWeb
        ? Scaffold(
            appBar: appBar as PreferredSizeWidget,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.deepOrange,
              onPressed: () => _openTransactionFormModal(context),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          )
        : Platform.isIOS
            ? CupertinoPageScaffold(
                navigationBar: appBar as ObstructingPreferredSizeWidget,
                child: bodyPage,
              )
            : Scaffold(
                appBar: appBar as PreferredSizeWidget,
                body: bodyPage,
                floatingActionButton: Platform.isIOS
                    ? Container()
                    : FloatingActionButton(
                        child: Icon(Icons.add),
                        backgroundColor: Colors.deepOrange,
                        onPressed: () => _openTransactionFormModal(context),
                      ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
  }
}
