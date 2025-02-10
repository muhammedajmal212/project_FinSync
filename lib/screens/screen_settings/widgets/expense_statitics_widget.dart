import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';

class ExpenseStatiticsWidget extends StatefulWidget {
  const ExpenseStatiticsWidget({super.key});

  @override
  State<ExpenseStatiticsWidget> createState() => _ExpenseStatiticsWidgetState();
}

class _ExpenseStatiticsWidgetState extends State<ExpenseStatiticsWidget> {
  Map<String, double> dataMap = {};
  @override
  void initState() {
    expensePieChartFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: CategoryDb.instance.expenseCategoryList.value.isNotEmpty
          ? PieChart(dataMap: dataMap)
          : const Center(
              child: Text("Empty Data"),
            ),
    );
  }

  void expensePieChartFunction() {
    if (CategoryDb.instance.expenseCategoryList.value.isNotEmpty) {
      for (int i = 0;
          i < CategoryDb.instance.expenseCategoryList.value.length;
          i++) {
        final categoryName =
            CategoryDb.instance.expenseCategoryList.value[i].name;
        final transaction =
            TransactionDb.instance.allTransactionList.value.where(
          (element) {
            return element.categoryModel?.name == categoryName;
          },
        ).toList();
        final amountList = transaction.map(
          (e) {
            return e.amount;
          },
        ).toList();
        dataMap[categoryName] = amountList.fold(
          0,
          (previousValue, currentValue) {
            return previousValue + currentValue;
          },
        );
      }
    }
  }
}
