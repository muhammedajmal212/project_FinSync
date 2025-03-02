import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:week5/provider/category_provider.dart';
import 'package:week5/provider/transaction_provider.dart';

class IncomeStatiticsWidget extends StatefulWidget {
  const IncomeStatiticsWidget({super.key});

  @override
  State<IncomeStatiticsWidget> createState() => _IncomeStatiticsWidgetState();
}

class _IncomeStatiticsWidgetState extends State<IncomeStatiticsWidget> {
  Map<String, double> dataMap = {};
  @override
  void initState() {
    incomePieChartFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child:
          Provider.of<CategoryProvider>(context).incomeCategoryList.isNotEmpty
              // CategoryDb.instance.incomeCategoryList.value.isNotEmpty
              ? PieChart(dataMap: dataMap)
              : const Center(
                  child: Text("Empty Data"),
                ),
    );
  }

  void incomePieChartFunction() {
    if (Provider.of<CategoryProvider>(context,listen: false).incomeCategoryList.isNotEmpty
        // CategoryDb.instance.incomeCategoryList.value.isNotEmpty
        ) {
      for (int i = 0;
          i < Provider.of<CategoryProvider>(context,listen: false).incomeCategoryList.length;
          i++) {
        final categoryName =
            // CategoryDb.instance.incomeCategoryList.value[i].name;
            Provider.of<CategoryProvider>(context,listen: false).incomeCategoryList[i].name;
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
