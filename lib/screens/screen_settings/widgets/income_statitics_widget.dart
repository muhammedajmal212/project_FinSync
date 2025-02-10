import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';

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
      child: CategoryDb.instance.incomeCategoryList.value.isNotEmpty
          ? PieChart(
            
            gradientList: const [
              [
              Color.fromRGBO(27, 129, 224, 1),
              Color.fromARGB(255, 220, 143, 255)
              ],[Color.fromARGB(255, 22, 179, 194),
              Color(0xFFC6A4E4)],[Color.fromARGB(255, 191, 77, 121),Color(0xFFFF7F50)]
            ], dataMap: dataMap)
          : const Center(
              child: Text("Empty Data"),
            ),
    );
  }

  void incomePieChartFunction() {
    if (CategoryDb.instance.incomeCategoryList.value.isNotEmpty) {
      for (int i = 0;
          i < CategoryDb.instance.incomeCategoryList.value.length;
          i++) {
        final categoryName =
            CategoryDb.instance.incomeCategoryList.value[i].name;
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
