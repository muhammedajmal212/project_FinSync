import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:week5/controller/category_controller.dart';
import 'package:week5/controller/transaction_controller.dart';

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
      child:
          Provider.of<CategoryProvider>(context).expenseCategoryList.isNotEmpty
              // CategoryDb.instance.expenseCategoryList.value.isNotEmpty
              ? PieChart(dataMap: dataMap)
              : const Center(
                  child: Text("Empty Data"),
                ),
    );
  }

  void expensePieChartFunction() {
    if (Provider.of<CategoryProvider>(context,listen: false).expenseCategoryList.isNotEmpty
        // CategoryDb.instance.expenseCategoryList.isNotEmpty
        ) {
      for (int i = 0;
          i < Provider.of<CategoryProvider>(context,listen: false).expenseCategoryList.length;

          //  CategoryDb.instance.expenseCategoryList.value.length;
          i++) {
        final categoryName =
            Provider.of<CategoryProvider>(context,listen: false).expenseCategoryList[i].name;
        // CategoryDb.instance.expenseCategoryList.value[i].name;
        final transaction =
            Provider.of<TransactionProvider>(context,listen: false).allTransactionlist.where(
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
